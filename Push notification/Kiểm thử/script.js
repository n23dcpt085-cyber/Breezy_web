// Send notification button
document.querySelector('.send-btn').addEventListener('click', () => {
  const title = document.querySelector('.quick-panel input[type="text"]').value;
  const content = document.querySelector('.quick-panel textarea').value;
  
  if (!title || !content) {
    alert('⚠️ Vui lòng điền đầy đủ thông tin!');
    return;
  }
  
  alert('✅ Thông báo đã được gửi thành công!');
  
  // Clear form
  document.querySelector('.quick-panel input[type="text"]').value = '';
  document.querySelector('.quick-panel textarea').value = '';
});

// Template quick use
document.querySelectorAll('.use-btn').forEach(btn => {
  btn.addEventListener('click', (e) => {
    e.stopPropagation();
    const template = e.target.closest('li').querySelector('span').textContent;
    
    const templates = {
      'Chào buổi sáng': {
        title: '☕ Chào buổi sáng! Giảm 20% cà phê',
        content: 'Bắt đầu ngày mới với tách cà phê thơm ngon. Giảm 20% tất cả các loại cà phê từ 7:00 - 11:00.'
      },
      'Khuyến mãi đặc biệt': {
        title: '🎉 Flash Sale 50% - Chỉ 2 giờ!',
        content: 'Đừng bỏ lỡ! Flash Sale cực sốc giảm đến 50% cho tất cả các món ăn uống. Áp dụng từ 16:00 - 18:00 hôm nay.'
      },
      'Yêu cầu đánh giá': {
        title: '⭐ Đánh giá trải nghiệm của bạn',
        content: 'Cảm ơn bạn đã sử dụng dịch vụ! Hãy chia sẻ trải nghiệm của bạn để chúng tôi phục vụ tốt hơn.'
      },
      'Cửa hàng mới': {
        title: '🏪 Cửa hàng mới tại Quận 7',
        content: 'Breezy mở cửa hàng mới tại Phú Mỹ Hưng, Quận 7, ghé thăm và nhận ngay ưu đãi 30% cho đơn đầu tiên!'
      }
    };
    
    const data = templates[template];
    if (data) {
      document.querySelector('.quick-panel input[type="text"]').value = data.title;
      document.querySelector('.quick-panel textarea').value = data.content;
      alert(`✅ Template "${template}" đã được áp dụng!`);
    }
  });
});

// Card actions menu
document.querySelectorAll('.card-actions').forEach(action => {
  action.addEventListener('click', () => {
    alert('📝 Tùy chọn: Sửa | Xóa | Sao chép');
  });
});

// Filter select
document.querySelector('.filter-select').addEventListener('change', (e) => {
  console.log('Filter changed to:', e.target.value);
});

// ==================== MODAL FUNCTIONALITY ====================

const modal = document.getElementById('createNotificationModal');
const createBtn = document.querySelector('.create-btn');
const closeBtn = document.querySelector('.modal-close');
const cancelBtn = document.getElementById('cancelBtn');
const nextStepBtn = document.getElementById('nextStepBtn');

// Open modal
createBtn.addEventListener('click', () => {
  modal.classList.add('show');
  document.body.style.overflow = 'hidden';
});

// Close modal
function closeModal() {
  modal.classList.remove('show');
  document.body.style.overflow = 'auto';
  // Reset form
  document.getElementById('notificationTitle').value = '';
  document.getElementById('notificationContent').value = '';
  updatePreview();
}

closeBtn.addEventListener('click', closeModal);
cancelBtn.addEventListener('click', closeModal);

// Close on outside click
modal.addEventListener('click', (e) => {
  if (e.target === modal) {
    closeModal();
  }
});

// Close on ESC key
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape' && modal.classList.contains('show')) {
    closeModal();
  }
});

// Character counters
const titleInput = document.getElementById('notificationTitle');
const contentTextarea = document.getElementById('notificationContent');
const titleCount = document.getElementById('titleCount');
const contentCount = document.getElementById('contentCount');

titleInput.addEventListener('input', (e) => {
  titleCount.textContent = e.target.value.length;
  updatePreview();
});

contentTextarea.addEventListener('input', (e) => {
  contentCount.textContent = e.target.value.length;
  updatePreview();
});

// Update preview
function updatePreview() {
  const title = titleInput.value || '🎉 🍹 ⭐ 🔥 👍';
  const content = contentTextarea.value || 'Nội dung thông báo sẽ hiển thị ở đây...';
  
  document.getElementById('previewTitle').textContent = title;
  document.getElementById('previewText').textContent = content;
}

// Emoji picker
document.querySelectorAll('.emoji-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    const emoji = btn.textContent;
    const cursorPos = titleInput.selectionStart;
    const textBefore = titleInput.value.substring(0, cursorPos);
    const textAfter = titleInput.value.substring(cursorPos);
    
    titleInput.value = textBefore + emoji + textAfter;
    titleInput.focus();
    titleInput.setSelectionRange(cursorPos + emoji.length, cursorPos + emoji.length);
    
    titleCount.textContent = titleInput.value.length;
    updatePreview();
    
    // Visual feedback
    btn.classList.add('selected');
    setTimeout(() => btn.classList.remove('selected'), 300);
  });
});

// Copy button
document.getElementById('copyBtn').addEventListener('click', () => {
  contentTextarea.select();
  document.execCommand('copy');
  alert('✅ Đã copy nội dung!');
});

// Image button
document.getElementById('imageBtn').addEventListener('click', () => {
  alert('📷 Chức năng upload ảnh đang được phát triển!');
});

// Image upload area
document.querySelector('.image-upload').addEventListener('click', () => {
  const input = document.createElement('input');
  input.type = 'file';
  input.accept = 'image/*';
  input.onchange = (e) => {
    const file = e.target.files[0];
    if (file) {
      alert(`✅ Đã chọn ảnh: ${file.name}`);
    }
  };
  input.click();
});

// Next step button
nextStepBtn.addEventListener('click', () => {
  const title = titleInput.value;
  const content = contentTextarea.value;
  
  if (!title || !content) {
    alert('⚠️ Vui lòng điền đầy đủ tiêu đề và nội dung!');
    return;
  }
  
  // In real app, this would go to step 2
  alert('✅ Tiếp tục đến bước 2: Chọn đối tượng nhận thông báo');
  closeModal();
});