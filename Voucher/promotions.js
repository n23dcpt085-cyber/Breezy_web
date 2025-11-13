// Modal management
const modal = document.getElementById('createPromoModal');
const openModalBtn = document.querySelector('.btn-primary');
const closeModalBtn = document.querySelector('.promo-modal-close');
const cancelBtn = document.getElementById('cancelPromoBtn');

let currentStep = 1;

// Open modal
openModalBtn.addEventListener('click', () => {
  modal.classList.add('show');
  document.body.style.overflow = 'hidden';
  currentStep = 1;
  showStep(1);
});

// Close modal
function closeModal() {
  modal.classList.remove('show');
  document.body.style.overflow = 'auto';
  currentStep = 1;
  showStep(1);
}

closeModalBtn.addEventListener('click', closeModal);
cancelBtn.addEventListener('click', closeModal);

// Close on outside click
modal.addEventListener('click', (e) => {
  if (e.target === modal) {
    closeModal();
  }
});

// ESC key
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape' && modal.classList.contains('show')) {
    closeModal();
  }
});

// Step navigation
function showStep(step) {
  // Update step indicator
  document.querySelectorAll('.step').forEach((s, index) => {
    s.classList.remove('active', 'completed');
    if (index + 1 < step) {
      s.classList.add('completed');
    } else if (index + 1 === step) {
      s.classList.add('active');
    }
  });

  // Update step content
  document.querySelectorAll('.step-content').forEach((content) => {
    content.classList.remove('active');
  });
  document.querySelector(`.step-content[data-step="${step}"]`).classList.add('active');

  // Update buttons
  const nextBtn = document.getElementById('nextStepBtn');
  const submitBtn = document.getElementById('submitPromoBtn');

  if (step === 3) {
    nextBtn.style.display = 'none';
    submitBtn.style.display = 'block';
  } else {
    nextBtn.style.display = 'block';
    submitBtn.style.display = 'none';
  }

  // Update modal title
  const titles = {
    1: 'Tạo chương trình khuyến mãi',
    2: 'Thời gian',
    3: 'Đối tượng & Phê duyệt'
  };
  document.getElementById('modalTitle').textContent = titles[step] || 'Tạo chương trình khuyến mãi';
}

// Next step
document.getElementById('nextStepBtn').addEventListener('click', () => {
  if (currentStep < 3) {
    currentStep++;
    showStep(currentStep);
  }
});

// Submit
document.getElementById('submitPromoBtn').addEventListener('click', () => {
  alert('✅ Chương trình khuyến mãi đã được tạo thành công!');
  closeModal();
});

// Save draft
document.getElementById('saveDraftBtn').addEventListener('click', () => {
  alert('💾 Đã lưu nháp');
});

// Tab switching
document.querySelectorAll('.tab-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.tab-btn').forEach(tab => tab.classList.remove('active'));
    btn.classList.add('active');
  });
});

// Other action buttons remain the same...
document.querySelectorAll('.action-btn.edit').forEach(btn => {
  btn.addEventListener('click', () => {
    alert('✏️ Mở form chỉnh sửa chương trình khuyến mãi');
  });
});

// Secondary button (Tạo mã voucher)
document.querySelector('.btn-secondary').addEventListener('click', () => {
  alert('🎟️ Mở form tạo mã voucher mới');
});