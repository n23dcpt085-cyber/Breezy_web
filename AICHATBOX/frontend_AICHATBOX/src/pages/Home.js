import React, { useState } from 'react';
import Navbar from '../components/Navbar';
import ChatBox from '../components/ChatBox';
import OrderSummary from '../components/OrderSummary';

function Home() {
  const [selectedDrink, setSelectedDrink] = useState(null);
  const [customization, setCustomization] = useState('');
  <ChatBox
  selectedDrink={selectedDrink}
  onSelectDrink={setSelectedDrink} // thêm dòng này nếu cần
  onCustomize={setCustomization}
/>


  return (
    <div>
      <Navbar />
      <div className="main-content">
        <div className="history-panel">
          <div className="chat-history">
            <h3>🕘 Trò chuyện của bạn</h3>
            <ul>
              <li>Đặt Matcha Latte</li>
              <li>Tư vấn menu mùa hè</li>
              <li>Hỏi về tích điểm</li>
              <li>Đặt hàng giao tận nơi</li>
              <li>Khuyến mãi tháng này</li>
            </ul>
          </div>
        </div>

        <div className="interaction-panel">
          <ChatBox
            selectedDrink={selectedDrink}
            onCustomize={setCustomization}
          />
          <OrderSummary
            drink={selectedDrink}
            customization={customization}
          />
          <button onClick={() => setSelectedDrink({
  name: 'Trà Chanh Dây Nhiệt Đới',
  price: 45000,
  image: require('../assets/drinks/tra-chanh-day-nhiet-doi.png')
})}>
  Chọn Trà Chanh Dây
</button>

        </div>
      </div>
    </div>
  );
}

export default Home;
