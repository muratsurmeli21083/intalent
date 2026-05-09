import React from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';

export default function ProfilVeLiveCv() {
  const navigate = useNavigate();
  return (
    <motion.div 
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.3 }}
      className="bg-surface font-body-md text-on-surface min-h-full flex flex-col overflow-x-hidden w-full relative"
    >
        
{/*  TopAppBar Shell  */}
<header className="sticky top-0 w-full z-50 flex items-center justify-between px-4 h-16 bg-white/80 backdrop-blur-md shadow-sm border-b border-slate-200 font-inter antialiased tracking-tight shrink-0">
<div className="flex items-center gap-3">
<img alt="intalent" className="h-8 object-contain" src="https://lh3.googleusercontent.com/aida/ADBb0ui6KVrYrRA7U3VTA5a-FEciPyigrd2NoJpc8hnw5Bcs1mWiiosaWDEhUq86TfR0qA7C434myFIK1u6baB-es8yI9TqQs-d3jepof49qNDAirjRYC1L1c69z9KxYtwtGObwm_QrEQC5iozsBrflGl-0Mcdz89grGB0-A-sUDcJ0JqYV2mU5HnhvrhTSuhkV80JUCDqpyWva3Nr7XoSpKLsJXCuaV3CfFRp0rPwOIyQUDdAwjYzax9hHSkhUkvJXQoNy73V8o4rY2"/>
</div>
<div className="flex items-center gap-4">
<button className="text-slate-500 hover:bg-slate-50 transition-colors p-2 rounded-full active:scale-95 duration-200">
<span className="material-symbols-outlined">notifications</span>
</button>
</div>
</header>
<main className="p-4 space-y-6">
{/*  Profile & Identity Section  */}
<section className="relative bg-white rounded-3xl p-6 border border-outline-variant shadow-sm flex flex-col items-center text-center">
<div className="relative mb-4">
<div className="w-24 h-24 rounded-full p-1 bg-gradient-to-tr from-primary to-tertiary">
<img alt="Caner Demir" className="w-full h-full rounded-full object-cover border-2 border-white" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAYZvGaaE87JFMLcbHDaXzFAvz3XWJQnaXwqOa13iCNr-IH_Hd8LQdnNITa8F5E3SPAddrz_wNKb_hqWoVN4SqCGQPwXNvYgdeL97bHoMBr6ZDqEIzbs88PH9IZlurenTPL2LTl6Oc78SCFFCOe7jOmFA7lEYvsLjZinSt4-1f_bG0S_B4foikB5zelGwRypiq5cx2hixUMMgbxPv_2V8cX6sgGX4sal5QoZP5Fcfo3Idb4FwaDwQB53EzZYf7qWa8fWddRZIkNCm0"/>
</div>
<div className="absolute -bottom-1 -right-1 bg-primary text-white p-1 rounded-full border-2 border-white flex items-center justify-center">
<span className="material-symbols-outlined text-[16px]" style={{ fontVariationSettings: "'FILL' 1" }}>verified</span>
</div>
</div>
<h1 className="font-headline-md text-headline-md text-on-surface mb-1">Caner Demir</h1>
<p className="font-body-sm text-body-sm text-secondary mb-3">Senior Product Designer &amp; Merit Analyst</p>
<div className="inline-flex items-center gap-2 bg-primary-container/10 px-4 py-1.5 rounded-full border border-primary-container/20">
<span className="material-symbols-outlined text-primary text-sm" style={{ fontVariationSettings: "'FILL' 1" }}>shield_with_heart</span>
<span className="text-primary font-label-bold text-label-bold uppercase tracking-widest">Verify Rozeti Aktif</span>
</div>
</section>
{/*  Bento Grid: Education & Experience  */}
<div className="grid grid-cols-1 gap-4">
{/*  Experience  */}
<section className="bg-white rounded-3xl p-6 border border-outline-variant shadow-sm">
<div className="flex items-center justify-between mb-4">
<h2 className="font-headline-md text-headline-md flex items-center gap-2 text-[18px]">
<span className="material-symbols-outlined text-primary">work_outline</span>
                        Deneyim
                    </h2>
<button className="text-primary hover:bg-primary-container/5 p-2 rounded-full transition-colors active:scale-90">
<span className="material-symbols-outlined">edit</span>
</button>
</div>
<div className="space-y-6">
<div className="relative pl-6 border-l border-outline-variant">
<div className="absolute -left-[5px] top-0 w-2 h-2 rounded-full bg-primary"></div>
<h3 className="font-label-bold text-on-surface">Senior Designer</h3>
<p className="text-body-sm text-secondary">TechLab Global • 2021 - Günümüz</p>
</div>
<div className="relative pl-6 border-l border-outline-variant">
<div className="absolute -left-[5px] top-0 w-2 h-2 rounded-full bg-outline"></div>
<h3 className="font-label-bold text-on-surface">Product Designer</h3>
<p className="text-body-sm text-secondary">Creative Sync • 2018 - 2021</p>
</div>
</div>
</section>
</div>
</main>
{/*  BottomNavBar Shell  */}
<nav className="sticky bottom-0 w-full z-50 flex justify-around items-center px-2 h-16 bg-white/90 backdrop-blur-lg border-t border-slate-200 shadow-sm shrink-0">
<button onClick={() => navigate('/kesfet')} className="flex flex-col items-center justify-center text-slate-400 hover:text-blue-500 transition-all active:scale-90">
<span className="material-symbols-outlined">explore</span>
<span className="text-[10px] font-medium font-inter">Keşfet</span>
</button>
<button onClick={() => navigate('/gelisim')} className="flex flex-col items-center justify-center text-slate-400 hover:text-blue-500 transition-all active:scale-90">
<span className="material-symbols-outlined">stars</span>
<span className="text-[10px] font-medium font-inter">Gelişim</span>
</button>
<button className="flex flex-col items-center justify-center text-primary active:scale-90">
<span className="material-symbols-outlined" style={{ fontVariationSettings: "'FILL' 1" }}>person</span>
<span className="text-[10px] font-medium font-inter">Profil</span>
</button>
</nav>

    </motion.div>
  );
}
