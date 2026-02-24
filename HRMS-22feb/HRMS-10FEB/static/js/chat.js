let CURRENT_USER_ID = null;
let ACTIVE_CHAT_USER_ID = null;
let refreshInterval = null;
let badgeInterval = null;
let currentTheme = 'whatsapp';
let avatarStyle = 'circle'; // circle, initials, gradient
let sidebarDensity = 'normal'; // compact, normal, spacious

// Function to get random color for avatar background
function getUserColor(userId) {
  const colors = [
    '#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', 
    '#98D8C8', '#F7DC6F', '#BB8FCE', '#85C1E2',
    '#F8B739', '#52B788', '#E63946', '#457B9D'
  ];
  return colors[userId % colors.length];
}

// Get user initials from username
function getUserInitials(username) {
  if (!username) return '?';
  const parts = username.trim().split(' ');
  if (parts.length >= 2) {
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
  return username.substring(0, 2).toUpperCase();
}

// Create avatar element based on current style
function createAvatar(userId, username, size = 'normal') {
  const avatarDiv = document.createElement("div");
  const sizeClass = size === 'small' ? 'message-avatar' : 
                    size === 'large' ? 'conversation-avatar' : 'contact-avatar';
  avatarDiv.className = sizeClass;
  
  const color = getUserColor(userId);
  avatarDiv.style.backgroundColor = color;
  
  if (avatarStyle === 'circle') {
    // Font Awesome icon
    const iconElement = document.createElement("i");
    iconElement.className = "fas fa-user-circle";
    avatarDiv.appendChild(iconElement);
  } else if (avatarStyle === 'initials') {
    // Text initials
    avatarDiv.textContent = getUserInitials(username);
    avatarDiv.style.fontSize = size === 'small' ? '0.8rem' : 
                               size === 'large' ? '1.1rem' : '0.95rem';
    avatarDiv.style.fontWeight = 'bold';
  } else if (avatarStyle === 'gradient') {
    // Gradient circle with first letter
    avatarDiv.textContent = username ? username[0].toUpperCase() : '?';
    avatarDiv.style.background = `linear-gradient(135deg, ${color} 0%, ${adjustColor(color, -30)} 100%)`;
    avatarDiv.style.fontSize = size === 'small' ? '0.9rem' : 
                               size === 'large' ? '1.2rem' : '1rem';
    avatarDiv.style.fontWeight = 'bold';
  }
  
  return avatarDiv;
}

// Helper function to darken/lighten color
function adjustColor(color, amount) {
  const num = parseInt(color.replace("#",""), 16);
  const r = Math.max(0, Math.min(255, (num >> 16) + amount));
  const g = Math.max(0, Math.min(255, ((num >> 8) & 0x00FF) + amount));
  const b = Math.max(0, Math.min(255, (num & 0x0000FF) + amount));
  return "#" + ((r << 16) | (g << 8) | b).toString(16).padStart(6, '0');
}

// Load saved settings from localStorage
function loadSavedSettings() {
  const savedTheme = localStorage.getItem('messenger-theme');
  const savedAvatar = localStorage.getItem('messenger-avatar-style');
  const savedDensity = localStorage.getItem('messenger-sidebar-density');
  
  if (savedTheme) currentTheme = savedTheme;
  if (savedAvatar) avatarStyle = savedAvatar;
  if (savedDensity) sidebarDensity = savedDensity;
}

// Save settings to localStorage
function saveSettings() {
  localStorage.setItem('messenger-theme', currentTheme);
  localStorage.setItem('messenger-avatar-style', avatarStyle);
  localStorage.setItem('messenger-sidebar-density', sidebarDensity);
}

// Apply theme to chat messages
function applyTheme(theme) {
  const chatMessages = document.getElementById('chatMessages');
  const conversationPanel = document.querySelector('.conversation-panel');
  const messagingContainer = document.querySelector('.messaging-container');
  
  if (chatMessages) {
    chatMessages.classList.remove('theme-whatsapp', 'theme-ocean', 'theme-sunset', 
                                   'theme-forest', 'theme-midnight', 'theme-peach');
    chatMessages.classList.add(`theme-${theme}`);
    
    document.querySelectorAll('.theme-option').forEach(btn => {
      btn.classList.remove('active');
      if (btn.dataset.theme === theme) {
        btn.classList.add('active');
      }
    });
  }
  
  // Apply theme to entire conversation panel (header + chat + input)
  if (conversationPanel) {
    conversationPanel.classList.remove('theme-whatsapp', 'theme-ocean', 'theme-sunset', 
                                       'theme-forest', 'theme-midnight', 'theme-peach');
    conversationPanel.classList.add(`theme-${theme}`);
  }
  
  // Apply theme to messaging container (affects contacts sidebar)
  if (messagingContainer) {
    messagingContainer.classList.remove('theme-whatsapp', 'theme-ocean', 'theme-sunset', 
                                        'theme-forest', 'theme-midnight', 'theme-peach');
    messagingContainer.classList.add(`theme-${theme}`);
  }
  
  // Update theme cards in settings
  document.querySelectorAll('.theme-card').forEach(card => {
    card.classList.remove('active');
    if (card.dataset.theme === theme) {
      card.classList.add('active');
    }
  });
  
  currentTheme = theme;
  saveSettings();
}

// Apply avatar style
function applyAvatarStyle(style) {
  avatarStyle = style;
  
  // Update active state
  document.querySelectorAll('.avatar-option').forEach(opt => {
    opt.classList.remove('active');
    if (opt.dataset.avatar === style) {
      opt.classList.add('active');
    }
  });
  
  saveSettings();
  
  // Reload contacts and messages if viewing a chat
  const searchInput = document.getElementById("contactSearch");
  if (searchInput) {
    loadContacts(searchInput.value);
  }
  
  if (ACTIVE_CHAT_USER_ID) {
    loadMessages(ACTIVE_CHAT_USER_ID);
  }
}

// Apply sidebar density
function applySidebarDensity(density) {
  const sidebar = document.getElementById('contactsSidebar');
  if (sidebar) {
    sidebar.classList.remove('compact', 'spacious');
    if (density !== 'normal') {
      sidebar.classList.add(density);
    }
  }
  
  // Update active state
  document.querySelectorAll('.sidebar-style-btn').forEach(btn => {
    btn.classList.remove('active');
    if (btn.dataset.density === density) {
      btn.classList.add('active');
    }
  });
  
  sidebarDensity = density;
  saveSettings();
}

document.addEventListener("DOMContentLoaded", async function () {

  // Load saved settings
  loadSavedSettings();

  /* ==========================
     ONLY ONE API CALL ON DOM LOAD - GET USER & START BADGE
  ========================== */
  try {
    const res = await fetch("/chat/me");
    const data = await res.json();

    if (!data.id) {
      console.error("User not logged in");
      return;
    }

    CURRENT_USER_ID = data.id;
    console.log("Logged in as:", CURRENT_USER_ID);

    updateUnreadBadge();

    badgeInterval = setInterval(() => {
      updateUnreadBadge();
    }, 50000);

  } catch (err) {
    console.error("Failed to fetch current user", err);
    return;
  }

  const chatBtn = document.getElementById("chatBtn");
  const messagingModalEl = document.getElementById("messagingModal");
  const contactsList = document.getElementById("contactsList");
  const searchInput = document.getElementById("contactSearch");
  const settingsBtn = document.getElementById("messengerSettingsBtn");
  const settingsDropdown = document.getElementById("settingsDropdown");

  if (!chatBtn || !messagingModalEl) return;

  const messagingModal = new bootstrap.Modal(messagingModalEl);

  // Apply saved density on load
  applySidebarDensity(sidebarDensity);

  /* ==========================
     SETTINGS DROPDOWN TOGGLE
  ========================== */
  if (settingsBtn) {
    
    settingsBtn.addEventListener('click', function(e) {
      alert('button clicked')
      e.stopPropagation();
      settingsDropdown.classList.toggle('show');
    });
  }

  // Close settings when clicking outside
  document.addEventListener('click', function(e) {
    if (!settingsDropdown.contains(e.target) && e.target !== settingsBtn) {
      settingsDropdown.classList.remove('show');
    }
  });

  /* ==========================
     THEME SELECTION IN SETTINGS
  ========================== */
  document.querySelectorAll('.theme-card').forEach(card => {
    card.addEventListener('click', function() {
      const theme = this.dataset.theme;
      applyTheme(theme);
    });
  });

  /* ==========================
     AVATAR STYLE SELECTION
  ========================== */
  document.querySelectorAll('.avatar-option').forEach(option => {
    option.addEventListener('click', function() {
      const style = this.dataset.avatar;
      applyAvatarStyle(style);
    });
  });

  /* ==========================
     SIDEBAR DENSITY SELECTION
  ========================== */
  document.querySelectorAll('.sidebar-style-btn').forEach(btn => {
    btn.addEventListener('click', function() {
      const density = this.dataset.density;
      applySidebarDensity(density);
    });
  });

  /* ==========================
     UPDATE UNREAD BADGE
  ========================== */
  function updateUnreadBadge() {
    fetch("/chat/unread-count")
      .then(res => res.json())
      .then(data => {
        const badge = document.getElementById("unreadBadge");
        const count = data.unread_count;

        if (count > 0) {
          badge.textContent = count > 99 ? '99+' : count;
          badge.style.display = "inline-block";
        } else {
          badge.style.display = "none";
        }
      })
      .catch(err => console.error("Failed to update badge:", err));
  }

  /* ==========================
     OPEN MODAL
  ========================== */
  chatBtn.addEventListener("click", function () {
    messagingModal.show();
    loadContacts("");
    updateUnreadBadge();
    
    // Apply saved theme to messaging container
    const messagingContainer = document.querySelector('.messaging-container');
    if (messagingContainer) {
      messagingContainer.classList.remove('theme-whatsapp', 'theme-ocean', 'theme-sunset', 
                                          'theme-forest', 'theme-midnight', 'theme-peach');
      messagingContainer.classList.add(`theme-${currentTheme}`);
    }
  });

  searchInput.addEventListener("keyup", function () {
    loadContacts(this.value);
  });

  /* ==========================
     LOAD CONTACTS
  ========================== */
  function loadContacts(query) {
    fetch(`/chat/users?q=${query}`)
      .then(res => res.json())
      .then(data => {
        contactsList.innerHTML = "";

        if (!data.length) {
          contactsList.innerHTML =
            "<p class='text-muted text-center mt-3'>No contacts found</p>";
          return;
        }

        data.forEach(user => {
          const div = document.createElement("div");
          div.className = "contact-item";
          div.dataset.userId = user.id;
          
          // Create avatar based on current style
          const avatarDiv = createAvatar(user.id, user.username, 'normal');
          div.appendChild(avatarDiv);
          
          // Username
          const nameSpan = document.createElement("span");
          nameSpan.textContent = user.username;
          nameSpan.className = "contact-name";
          div.appendChild(nameSpan);

          // Unread badge
          if (user.unread_count > 0) {
            const unreadBadge = document.createElement("span");
            unreadBadge.className = "contact-unread-badge";
            unreadBadge.textContent = user.unread_count > 99 ? '99+' : user.unread_count;
            div.appendChild(unreadBadge);
            
            div.classList.add("has-unread");
          }

          if (ACTIVE_CHAT_USER_ID && Number(user.id) === Number(ACTIVE_CHAT_USER_ID)) {
            div.classList.add("active");
          }

          div.onclick = (e) => openConversation(user.id, user.username, e);
          contactsList.appendChild(div);
        });
      })
      .catch(err => console.error("Failed to load contacts:", err));
  }

  /* ==========================
     OPEN CONVERSATION
  ========================== */
  function openConversation(userId, userName, event) {
    ACTIVE_CHAT_USER_ID = userId;

    if (refreshInterval) {
      clearInterval(refreshInterval);
    }

    document.querySelectorAll(".contact-item").forEach(item =>
      item.classList.remove("active")
    );
    
    event.currentTarget.classList.add("active");

    // Create header HTML with avatar
    const headerAvatar = createAvatar(userId, userName, 'large');
    
    const conversationPanel = document.querySelector(".conversation-panel");
    const messagingContainer = document.querySelector('.messaging-container');
    
    conversationPanel.innerHTML = `
      <div class="conversation-header">
        <div id="conversationAvatarContainer"></div>
        <h6 class="mb-0">${userName}</h6>
      </div>

      <div class="chat-messages theme-${currentTheme}" id="chatMessages">
        <div class="chat-loading" id="chatLoading">
          <div class="chat-loading-spinner"></div>
          <span class="chat-loading-text">Loading...</span>
        </div>
      </div>

      <div class="chat-input-wrapper">
        <input
          type="text"
          id="messageInput"
          class="form-control"
          placeholder="Type a message…"
        />
        <button class="btn btn-primary" id="sendMessageBtn">
          Send
        </button>
      </div>
    `;

    // Apply theme to entire conversation panel
    conversationPanel.classList.remove('theme-whatsapp', 'theme-ocean', 'theme-sunset', 
                                       'theme-forest', 'theme-midnight', 'theme-peach');
    conversationPanel.classList.add(`theme-${currentTheme}`);
    
    // Apply theme to messaging container (affects contacts sidebar)
    if (messagingContainer) {
      messagingContainer.classList.remove('theme-whatsapp', 'theme-ocean', 'theme-sunset', 
                                          'theme-forest', 'theme-midnight', 'theme-peach');
      messagingContainer.classList.add(`theme-${currentTheme}`);
    }

    // Insert avatar into container
    document.getElementById('conversationAvatarContainer').appendChild(headerAvatar);

    loadMessages(userId);

    refreshInterval = setInterval(() => {
      loadMessages(userId);
    }, 2000);

    document
      .getElementById("sendMessageBtn")
      .addEventListener("click", sendMessage);

    document
      .getElementById("messageInput")
      .addEventListener("keypress", e => {
        if (e.key === "Enter") sendMessage();
      });
  }

  /* ==========================
     SHOW/HIDE LOADING
  ========================== */
  function showLoading() {
    const loader = document.getElementById("chatLoading");
    if (loader) {
      loader.classList.add("show");
    }
  }

  function hideLoading() {
    const loader = document.getElementById("chatLoading");
    if (loader) {
      loader.classList.remove("show");
    }
  }

  /* ==========================
     LOAD MESSAGES
  ========================== */
  function loadMessages(userId, showLoader = false) {
    if (showLoader) {
      showLoading();
    }

    fetch(`/chat/messages/${userId}`)
      .then(res => res.json())
      .then(messages => {
        hideLoading();
        
        const box = document.getElementById("chatMessages");

        Array.from(box.children).forEach(child => {
          if (child.id !== 'chatLoading') {
            child.remove();
          }
        });

        if (!messages.length) {
          const placeholder = document.createElement('div');
          placeholder.className = 'text-muted text-center mt-3';
          placeholder.textContent = 'No messages yet 👋';
          box.appendChild(placeholder);
          return;
        }

        // Get sender username for avatars
        const senderUsernames = {};
        
        messages.forEach(msg => {
          const messageWrapper = document.createElement("div");
          messageWrapper.className = "message-wrapper";
          
          const isSent = Number(msg.sender_id) === Number(CURRENT_USER_ID);
          messageWrapper.classList.add(isSent ? "sent-wrapper" : "received-wrapper");

          // Add avatar for received messages
          if (!isSent) {
            // Use the username from active chat
            const username = document.querySelector('.conversation-header h6')?.textContent || 'User';
            const avatar = createAvatar(msg.sender_id, username, 'small');
            messageWrapper.appendChild(avatar);
          }

          // Message bubble
          const div = document.createElement("div");
          div.classList.add("message");
          div.classList.add(isSent ? "sent" : "received");

          // Message text
          const textSpan = document.createElement("span");
          textSpan.className = "message-text";
          textSpan.textContent = msg.message;
          div.appendChild(textSpan);

          // Message info
          const infoDiv = document.createElement("div");
          infoDiv.className = "message-info";

          const timestamp = new Date(msg.created_at);
          const timeString = timestamp.toLocaleTimeString('en-US', { 
            hour: 'numeric', 
            minute: '2-digit',
            hour12: true 
          });
          
          const timeSpan = document.createElement("span");
          timeSpan.className = "message-time";
          timeSpan.textContent = timeString;
          infoDiv.appendChild(timeSpan);

          if (isSent) {
            const statusSpan = document.createElement("span");
            statusSpan.className = "message-status";
            
            if (msg.status === 'read') {
              statusSpan.innerHTML = " ✓✓";
              statusSpan.classList.add("read");
            } else if (msg.status === 'sent') {
              statusSpan.innerHTML = " ✓";
              statusSpan.classList.add("sent-status");
            }
            
            infoDiv.appendChild(statusSpan);
          }

          div.appendChild(infoDiv);
          messageWrapper.appendChild(div);
          box.appendChild(messageWrapper);
        });

        box.scrollTop = box.scrollHeight;

        loadContacts(searchInput.value);
        updateUnreadBadge();
      })
      .catch(err => {
        hideLoading();
        console.error("Failed to load messages:", err);
      });
  }

  /* ==========================
     SEND MESSAGE
  ========================== */
  function sendMessage() {
    const input = document.getElementById("messageInput");
    const text = input.value.trim();

    if (!text || !ACTIVE_CHAT_USER_ID) return;

    showLoading();

    fetch("/chat/messages", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        receiver_id: ACTIVE_CHAT_USER_ID,
        message: text
      })
    })
      .then(() => {
        input.value = "";
        loadMessages(ACTIVE_CHAT_USER_ID, true);
      })
      .catch(err => {
        hideLoading();
        console.error("Failed to send message:", err);
      });
  }

  /* ==========================
     MODAL CLOSE HANDLER
  ========================== */
  messagingModalEl.addEventListener('hidden.bs.modal', () => {
    if (refreshInterval) {
      clearInterval(refreshInterval);
      refreshInterval = null;
    }
    ACTIVE_CHAT_USER_ID = null;
    settingsDropdown.classList.remove('show');
    
    updateUnreadBadge();
  });

  /* ==========================
     CLEANUP
  ========================== */
  window.addEventListener('beforeunload', () => {
    if (badgeInterval) clearInterval(badgeInterval);
    if (refreshInterval) clearInterval(refreshInterval);
  });
});