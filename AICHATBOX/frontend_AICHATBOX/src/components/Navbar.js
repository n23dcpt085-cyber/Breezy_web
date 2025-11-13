import React from 'react';

function Navbar() {
  return (
    <nav className="navbar">
      <ul>
        <li>Trang chủ</li>
        <li>Thực đơn</li>
        <li>Cửa hàng</li>
        <li>Về chúng tôi</li>
        <li>AI Trợ lý</li>
      </ul>
      <div className="lang-switch">
        <button>VI</button>
        <button>EN</button>
      </div>
    </nav>
  );
}

export default Navbar;
