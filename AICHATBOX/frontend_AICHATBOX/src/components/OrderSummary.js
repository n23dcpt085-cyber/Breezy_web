import React from 'react';

function OrderSummary({ drink, customization }) {
  if (!drink) return null;

  return (
    <div className="order-summary">
      <h2>🧾 Tóm tắt đơn hàng</h2>
      <p>{drink.name}</p>
      <p>{customization}</p>
      <p>Tổng: {drink.price.toLocaleString()}đ</p>
      <div className="buttons">
        <button>Thêm topping</button>
        <button>Đặt hàng luôn</button>
        <button>Xem thêm món</button>
      </div>
    </div>
  );
}

export default OrderSummary;
