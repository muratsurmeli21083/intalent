import React from 'react';
import { useNavigate } from 'react-router-dom';

export default function GiriYapStitch() {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-white relative overflow-hidden">
      {/* Subtle Tech Background Overlay */}
      <div className="absolute inset-0 opacity-3" style={{ backgroundImage: 'url(https://www.transparenttextures.com/patterns/carbon-fibre.png)' }}></div>
      
      {/* Decorative Soft Gradients */}
      <div className="absolute top-[-100px] right-[-100px] w-[500px] h-[500px] rounded-full" style={{ backgroundColor: 'rgba(0, 62, 199, 0.05)' }}></div>
      <div className="absolute bottom-[-100px] left-[-100px] w-[400px] h-[400px] rounded-full" style={{ backgroundColor: 'rgba(210, 224, 254, 0.2)' }}></div>
      
      {/* Content */}
      <div className="relative pt-12 pb-12 overflow-y-auto max-h-screen">
        <div className="px-4 max-w-md mx-auto">
          {/* Logo Section */}
          <div className="text-center mt-12 mb-12">
            <img
              src="https://lh3.googleusercontent.com/aida/ADBb0ui6KVrYrRA7U3VTA5a-FEciPyigrd2NoJpc8hnw5Bcs1mWiiosaWDEhUq86TfR0qA7C434myFIK1u6baB-es8yI9TqQs-d3jepof49qNDAirjRYC1L1c69z9KxYtwtGObwm_QrEQC5iozsBrflGl-0Mcdz89grGB0-A-sUDcJ0JqYV2mU5HnhvrhTSuhkV80JUCDqpyWva3Nr7XoSpKLsJXCuaV3CfFRp0rPwOIyQUDdAwjYzax9hHSkhUkvJXQoNy73V8o4rY2"
              alt="intalent"
              className="w-32 h-auto mx-auto mb-2"
            />
            <h1 className="text-4xl font-semibold tracking-tight text-[#191C1E] mb-2">
              intalent
            </h1>
            <p className="text-sm text-[#434656]">
              Geleceğin Yetenek Laboratuvarı
            </p>
          </div>
          
          {/* Login Card */}
          <div className="bg-white bg-opacity-70 rounded-3xl border border-white border-opacity-30 shadow-sm p-6">
            <h2 className="text-2xl font-semibold text-[#191C1E] text-center">
              Hoş Geldiniz
            </h2>
            <p className="text-sm text-[#434656] text-center mt-1 mb-6">
              Lütfen profesyonel hesabınızla giriş yapın.
            </p>
            
            {/* LinkedIn Button */}
            <button
              onClick={() => navigate('/tercihler')}
              className="w-full bg-[#003EC7] text-white py-3 rounded-lg font-semibold text-sm flex items-center justify-center gap-2 hover:bg-[#003EC7]/90 transition-colors"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.658 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1" />
              </svg>
              LinkedIn ile Bağlan
            </button>
            
            {/* Divider */}
            <div className="flex items-center gap-4 my-6">
              <div className="flex-1 border-t border-[#C3C5D9]"></div>
              <span className="text-xs font-semibold text-[#737688]">VEYA</span>
              <div className="flex-1 border-t border-[#C3C5D9]"></div>
            </div>
            
            {/* Email Section */}
            <label className="text-xs font-semibold text-[#434656] block mb-2">
              E-posta ile devam edin
            </label>
            <input
              type="email"
              placeholder="E-posta adresiniz"
              className="w-full px-4 py-3 border border-[#C3C5D9] rounded-lg focus:outline-none focus:border-[#003EC7] bg-white"
            />
            
            {/* Password Section */}
            <label className="text-xs font-semibold text-[#434656] block mt-4 mb-2">
              Şifre
            </label>
            <input
              type="password"
              placeholder="Şifreniz"
              className="w-full px-4 py-3 border border-[#C3C5D9] rounded-lg focus:outline-none focus:border-[#003EC7] bg-white"
            />
            
            {/* Continue Button */}
            <button
              onClick={() => navigate('/tercihler')}
              className="w-full mt-6 bg-[#515F78] text-white py-3 rounded-lg font-semibold text-sm hover:bg-[#515F78]/90 transition-colors"
            >
              Devam Et
            </button>
            
            {/* Consent */}
            <div className="mt-6 flex gap-2 text-xs text-[#434656]">
              <input type="checkbox" className="mt-0.5" id="consent" />
              <label htmlFor="consent">
                Kullanım koşullarını ve KVKK onayı metnini okudum, kabul ediyorum.
              </label>
            </div>
          </div>
          
          {/* Footer Visual */}
          <div className="flex justify-center gap-8 mt-12 mb-8 text-xs font-bold text-[#737688]">
            <div className="flex items-center gap-1">
              <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z" />
              </svg>
              GÜVENLİ ALTYAPI
            </div>
            <div className="flex items-center gap-1">
              <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V5h14v14zm-5.04-6.71l-2.75 3.54-1.3-1.54L6.5 17h11l-3.54-4.71z" />
              </svg>
              VERİ ODAKLI
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
