import React, { useState } from 'react';
import DrinkCard from './DrinkCard';

function ChatBox({ selectedDrink, onCustomize }) {
  const [input, setInput] = useState('');
  const [messages, setMessages] = useState([
    { type: 'bot', text: '🥤 Xin chào! Bạn muốn uống gì hôm nay?' }
  ]);

  const handleSend = () => {
    if (!input) return;
    setMessages([...messages, { type: 'user', text: input }]);
    onCustomize(input);
    setInput('');
  };

  return (
    <div className="chat-box">
      <div className="chat-log">
        {messages.map((msg, index) => (
          <div
            key={index}
            className={`chat-msg ${msg.type === 'user' ? 'user-msg' : 'bot-msg'}`}
          >
            {msg.text}
          </div>
        ))}

        {selectedDrink && (
          <div className="bot-msg drinkcard-wrapper">
            <DrinkCard
              drink={selectedDrink}
              onAdd={() => console.log('Đặt hàng')}
            />
          </div>
        )}
      </div>

      <input
        type="text"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        onKeyDown={(e) => e.key === 'Enter' && handleSend()}
        placeholder="Nhập yêu cầu của bạn..."
      />
    </div>
  );
}

export default ChatBox;
