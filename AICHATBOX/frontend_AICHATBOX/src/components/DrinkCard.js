import React from 'react';

function DrinkCard({ drink, onAdd }) {
  if (!drink) return null;

  return (
    <div className="drink-card">
      <img src={drink.image} alt={drink.name} className="drink-image" />

      <div className="drink-details">
        <p>
          <strong>{drink.name}</strong><br />
          Size M • ít đá • ít đường<br />
          Tổng: {drink.price.toLocaleString()}đ
        </p>

        <div className="action-row">
          <button onClick={() => console.log('Thêm topping')}>Thêm topping</button>
          <button onClick={onAdd}>Đặt hàng luôn</button>
          <button>Xem thêm món</button>
        </div>
      </div>
    </div> // ✅ Tất cả JSX đã nằm trong thẻ <div className="drink-card">
  );
}

export default DrinkCard;
