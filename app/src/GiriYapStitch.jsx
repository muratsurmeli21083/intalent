import React from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';

export default function GiriYapStitch() {
  const navigate = useNavigate();
  return (
    <motion.div 
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.3 }}
      className="bg-surface font-body-md text-on-surface min-h-full flex flex-col overflow-x-hidden w-full relative"
    >
        
{/*  Subtle Tech Background Overlay  */}
<div className="fixed inset-0 tech-pattern pointer-events-none"></div>
{/*  Decorative Soft Gradients  */}
<div className="fixed top-[-10%] right-[-10%] w-[500px] h-[500px] bg-primary/5 rounded-full blur-[100px] pointer-events-none"></div>
<div className="fixed bottom-[-10%] left-[-10%] w-[400px] h-[400px] bg-secondary-container/20 rounded-full blur-[80px] pointer-events-none"></div>
<main className="relative z-10 w-full max-w-md px-margin-mobile flex flex-col items-center">
{/*  Logo Section  */}
<header className="mb-lg text-center">
<div className="flex items-center justify-center mb-base">
<div className="w-32 h-auto mb-xs"><img alt="intalent logo" className="w-full h-auto object-contain" src="https://lh3.googleusercontent.com/aida/ADBb0ui6KVrYrRA7U3VTA5a-FEciPyigrd2NoJpc8hnw5Bcs1mWiiosaWDEhUq86TfR0qA7C434myFIK1u6baB-es8yI9TqQs-d3jepof49qNDAirjRYC1L1c69z9KxYtwtGObwm_QrEQC5iozsBrflGl-0Mcdz89grGB0-A-sUDcJ0JqYV2mU5HnhvrhTSuhkV80JUCDqpyWva3Nr7XoSpKLsJXCuaV3CfFRp0rPwOIyQUDdAwjYzax9hHSkhUkvJXQoNy73V8o4rY2"/></div>
</div>
<h1 className="font-headline-lg text-headline-lg text-on-background tracking-tighter lowercase">intalent</h1>
<p className="font-body-sm text-body-sm text-on-surface-variant mt-xs">Geleceğin Yetenek Laboratuvarı</p>
</header>
{/*  Login Card  */}
<section className="w-full glass-card p-md rounded-full shadow-sm">
<div className="text-center mb-md">
<h2 className="font-headline-md text-headline-md text-on-surface mb-xs">Hoş Geldiniz</h2>
<p className="font-body-sm text-body-sm text-on-surface-variant">Lütfen profesyonel hesabınızla giriş yapın.</p>
</div>
{/*  Primary Action: LinkedIn Button  */}
<button onClick={() => navigate('/profil')} className="w-full flex items-center justify-center gap-sm bg-primary py-sm px-md rounded-xl text-on-primary hover:bg-primary-container transition-all active:scale-[0.98] shadow-md shadow-primary/10 mb-md">
<svg className="w-5 h-5 fill-current" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
<path d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.79M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z"></path>
</svg>
<span className="font-label-bold text-label-bold">LinkedIn ile Bağlan</span>
</button>
{/*  Secondary Divider  */}
<div className="flex items-center gap-base mb-md">
<div className="h-[1px] flex-1 bg-outline-variant"></div>
<span className="font-label-bold text-label-bold text-outline uppercase">veya</span>
<div className="h-[1px] flex-1 bg-outline-variant"></div>
</div>
{/*  Email (Placeholder/Optional look)  */}
<div className="space-y-sm mb-lg">
<div className="flex flex-col gap-md">
<div className="relative">
<label className="block text-label-bold text-on-surface-variant mb-xs ml-1" htmlFor="email-input">E-posta ile devam edin</label>
<input className="w-full bg-surface-container-lowest border border-outline-variant rounded-xl px-md py-sm font-body-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all placeholder:text-outline/50" id="email-input" placeholder="E-posta adresiniz" type="email"/><div className="relative mt-md">
<label className="block text-label-bold text-on-surface-variant mb-xs ml-1" htmlFor="password-input">Şifre</label>
<input className="w-full bg-surface-container-lowest border border-outline-variant rounded-xl px-md py-sm font-body-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent transition-all placeholder:text-outline/50" id="password-input" placeholder="Şifreniz" type="password"/>
</div>
</div>
<button onClick={() => navigate('/profil')} className="w-full py-sm px-md bg-secondary text-on-secondary rounded-xl font-label-bold text-label-bold hover:bg-on-secondary-fixed-variant transition-all active:scale-[0.98] shadow-sm">
                    Devam Et
                </button>
</div>
</div>
{/*  Consent Section  */}
<div className="flex items-start gap-sm">
<div className="relative flex items-center pt-xs">
<input className="w-5 h-5 rounded border-outline-variant text-primary focus:ring-primary transition-all cursor-pointer" id="kvkk-consent" type="checkbox"/>
</div>
<label className="font-body-sm text-body-sm text-on-surface-variant leading-tight cursor-pointer" htmlFor="kvkk-consent">
                    Kullanım koşullarını ve <a className="text-primary font-medium hover:underline" href="#">KVKK onayı</a> metnini okudum, kabul ediyorum.
                </label>
</div>
</section>
{/*  Footer Visual/Info  */}
<footer className="mt-lg w-full">
<div className="flex flex-wrap justify-center gap-md mb-md">
<div className="flex items-center gap-xs text-outline">
<span className="material-symbols-outlined text-[18px]">verified_user</span>
<span className="font-label-bold text-[10px] tracking-widest uppercase">Güvenli Altyapı</span>
</div>
<div className="flex items-center gap-xs text-outline">
<span className="material-symbols-outlined text-[18px]">analytics</span>
<span className="font-label-bold text-[10px] tracking-widest uppercase">Veri Odaklı</span>
</div>
</div>
</footer>
</main>
{/*  Bottom Navigation Shell Suppression (As per Rule: suppress on Login)  */}
{/*  This screen represents a focused journey; nav shell is excluded  */}

    </motion.div>
  );
}
