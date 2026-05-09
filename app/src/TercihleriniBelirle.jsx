import React from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';

export default function TercihleriniBelirle() {
  const navigate = useNavigate();
  return (
    <motion.div 
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.3 }}
      className="bg-surface font-body-md text-on-surface min-h-full flex flex-col overflow-x-hidden w-full relative"
    >
        
{/*  Top Navigation Suppression: Onboarding is Transactional  */}
<header className="sticky top-0 w-full z-50 flex items-center justify-between px-4 h-16 bg-white/80 backdrop-blur-md border-b border-slate-200 shrink-0">
<div className="flex items-center gap-2"><img alt="intalent logo" className="h-8 w-auto" src="https://lh3.googleusercontent.com/aida/ADBb0ui6KVrYrRA7U3VTA5a-FEciPyigrd2NoJpc8hnw5Bcs1mWiiosaWDEhUq86TfR0qA7C434myFIK1u6baB-es8yI9TqQs-d3jepof49qNDAirjRYC1L1c69z9KxYtwtGObwm_QrEQC5iozsBrflGl-0Mcdz89grGB0-A-sUDcJ0JqYV2mU5HnhvrhTSuhkV80JUCDqpyWva3Nr7XoSpKLsJXCuaV3CfFRp0rPwOIyQUDdAwjYzax9hHSkhUkvJXQoNy73V8o4rY2"/></div>
<div className="flex items-center gap-sm">
<span className="font-label-bold text-label-bold text-primary px-3 py-1 bg-primary-fixed rounded-full">ADIM 2/4</span>
</div>
</header>
<main className="min-h-screen pt-24 pb-32 px-margin-mobile md:px-margin-desktop flex flex-col items-center">
<div className="max-w-3xl w-full space-y-lg">
{/*  Welcome Header  */}
<div className="space-y-xs">
<h1 className="font-headline-lg text-headline-lg text-on-surface tracking-tight">Kariyer Hedeflerini Belirleyelim</h1>
<p className="font-body-md text-body-md text-on-surface-variant">Senin için en uygun fırsatları "Merit Lab" algoritmalarımızla eşleştireceğiz.</p>
</div>
{/*  Bento Grid Questions  */}
<div className="grid grid-cols-1 md:grid-cols-12 gap-gutter">
{/*  Question 1: Sectors  */}
<div className="md:col-span-12 glass-card rounded-xl p-md shadow-sm">
<div className="flex items-center gap-sm mb-md">
<div className="p-2 bg-primary-container rounded-lg text-on-primary">
<span className="material-symbols-outlined" data-icon="domain">domain</span>
</div>
<h2 className="font-headline-md text-headline-md">Hangi sektörlerde kariyer yapmak istersin?</h2>
</div>
<div className="flex flex-wrap gap-sm">
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="account_balance">account_balance</span>
<span className="font-body-sm text-body-sm">Finance</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full chip-active transition-all active:scale-95 shadow-lg shadow-primary/20">
<span className="material-symbols-outlined text-sm" data-icon="shopping_bag" style={{ fontVariationSettings: "'FILL' 1" }}>shopping_bag</span>
<span className="font-body-sm text-body-sm">Retail</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="computer">computer</span>
<span className="font-body-sm text-body-sm">IT &amp; Tech</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="health_and_safety">health_and_safety</span>
<span className="font-body-sm text-body-sm">Health Care</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full chip-active transition-all active:scale-95 shadow-lg shadow-primary/20">
<span className="material-symbols-outlined text-sm" data-icon="factory" style={{ fontVariationSettings: "'FILL' 1" }}>factory</span>
<span className="font-body-sm text-body-sm">Manufacturing</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="movie">movie</span>
<span className="font-body-sm text-body-sm">Entertainment</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="more_horiz">more_horiz</span>
<span className="font-body-sm text-body-sm">Diğer</span>
</button>
</div>
</div><div className="md:col-span-12 glass-card rounded-xl p-md shadow-sm">
<div className="flex items-center gap-sm mb-md">
<div className="p-2 bg-secondary-container rounded-lg text-on-secondary-container">
<span className="material-symbols-outlined" data-icon="work">work</span>
</div>
<h2 className="font-headline-md text-headline-md">Mesleğiniz nedir?</h2>
</div>
<div className="flex flex-wrap gap-sm">
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="school">school</span>
<span className="font-body-sm text-body-sm">Öğretmen</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="gavel">gavel</span>
<span className="font-body-sm text-body-sm">Avukat</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="terminal">terminal</span>
<span className="font-body-sm text-body-sm">Bilgisayar Mühendisi</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="architecture">architecture</span>
<span className="font-body-sm text-body-sm">Mimar</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="medical_services">medical_services</span>
<span className="font-body-sm text-body-sm">Doktor</span>
</button>
<button className="flex items-center gap-2 px-4 py-2 rounded-full border border-outline-variant hover:border-primary hover:bg-primary-fixed transition-all active:scale-95">
<span className="material-symbols-outlined text-sm" data-icon="more_horiz">more_horiz</span>
<span className="font-body-sm text-body-sm">Diğer</span>
</button>
</div>
</div>
{/*  Question 2: Roles  */}
<div className="md:col-span-12 glass-card rounded-xl p-md shadow-sm relative overflow-hidden">
<div className="absolute top-0 right-0 p-lg opacity-5 pointer-events-none">
<span className="material-symbols-outlined text-[120px]" data-icon="person_search">person_search</span>
</div>
<div className="flex items-center gap-sm mb-md">
<div className="p-2 bg-tertiary-container rounded-lg text-on-tertiary">
<span className="material-symbols-outlined" data-icon="badge">badge</span>
</div>
<h2 className="font-headline-md text-headline-md">Hedef rollerin neler?</h2>
</div>
<div className="space-y-md">
<div className="relative">
<span className="absolute inset-y-0 left-3 flex items-center text-outline">
<span className="material-symbols-outlined" data-icon="search">search</span>
</span>
<input className="w-full pl-10 pr-4 py-3 rounded-xl border border-outline-variant focus:ring-2 focus:ring-primary focus:border-transparent outline-none bg-white transition-all" placeholder="Rol ara (örn: Backend Dev)" type="text"/>
</div>
<div className="flex flex-wrap gap-sm">
<div className="flex items-center gap-2 px-4 py-2 rounded-xl bg-secondary-container text-on-secondary-container border border-secondary-fixed shadow-sm">
<span className="font-body-sm text-body-sm font-medium">Backend Dev</span>
<button className="hover:text-error transition-colors flex items-center">
<span className="material-symbols-outlined text-sm" data-icon="close">close</span>
</button>
</div>
<div className="flex items-center gap-2 px-4 py-2 rounded-xl bg-secondary-container text-on-secondary-container border border-secondary-fixed shadow-sm">
<span className="font-body-sm text-body-sm font-medium">Analist</span>
<button className="hover:text-error transition-colors flex items-center">
<span className="material-symbols-outlined text-sm" data-icon="close">close</span>
</button>
</div>
<div className="flex items-center gap-2 px-4 py-2 rounded-xl bg-secondary-container text-on-secondary-container border border-secondary-fixed shadow-sm">
<span className="font-body-sm text-body-sm font-medium">Mağaza Müdürü</span>
<button className="hover:text-error transition-colors flex items-center">
<span className="material-symbols-outlined text-sm" data-icon="close">close</span>
</button>
</div>
</div>
<div className="pt-sm">
<p className="font-label-bold text-label-bold text-outline mb-sm uppercase tracking-widest">Popüler Öneriler</p>
<div className="flex flex-wrap gap-xs">
<button className="px-3 py-1 rounded-full text-body-sm border border-outline-variant text-on-surface-variant hover:bg-surface-container-high transition-colors">UI/UX Designer</button>
<button className="px-3 py-1 rounded-full text-body-sm border border-outline-variant text-on-surface-variant hover:bg-surface-container-high transition-colors">Data Scientist</button>
<button className="px-3 py-1 rounded-full text-body-sm border border-outline-variant text-on-surface-variant hover:bg-surface-container-high transition-colors">Project Manager</button>
<button className="px-3 py-1 rounded-full text-body-sm border border-outline-variant text-on-surface-variant hover:bg-surface-container-high transition-colors">Fullstack Engineer</button>
</div>
</div>
</div>
</div>
{/*  Merit Insight Widget  */}
<div className="md:col-span-12 bg-primary-container rounded-xl p-md text-on-primary flex flex-col md:flex-row items-center gap-md">
<div className="h-24 w-24 flex-shrink-0 bg-white/20 rounded-full flex items-center justify-center backdrop-blur-sm">
<span className="material-symbols-outlined text-4xl" data-icon="auto_awesome">auto_awesome</span>
</div>
<div className="flex-1 space-y-xs text-center md:text-left">
<h3 className="font-headline-md text-headline-md text-on-primary-container">Eşleşme Kalitesini Artır</h3>
<p className="font-body-sm text-body-sm opacity-90">Sektör ve rol seçimlerin, algoritmanızın size en uygun 'Merit Lab' puanına sahip şirketleri getirmesini sağlar. Ne kadar spesifik olursan o kadar iyi!</p>
</div>
</div>
</div>
</div>
</main>
{/*  Bottom Action Bar (Transactional Floating State)  */}
<footer className="sticky bottom-0 w-full bg-white/90 backdrop-blur-lg border-t border-slate-200 px-margin-mobile py-4 flex items-center justify-between z-50 shrink-0">
<button onClick={() => navigate('/profil')} className="flex items-center gap-2 font-label-bold text-label-bold text-secondary hover:text-on-surface transition-colors">
<span className="material-symbols-outlined" data-icon="arrow_back">arrow_back</span>
            Geri Dön
        </button>
<div className="flex items-center gap-md">
<div className="hidden md:flex flex-col items-end">
<span className="font-numeric-data text-numeric-data text-outline">Kalan Adımlar</span>
<div className="flex gap-1">
<div className="h-1.5 w-6 rounded-full bg-primary"></div>
<div className="h-1.5 w-6 rounded-full bg-primary"></div>
<div className="h-1.5 w-6 rounded-full bg-slate-200"></div>
<div className="h-1.5 w-6 rounded-full bg-slate-200"></div>
</div>
</div>
<button onClick={() => navigate('/cv')} className="px-lg py-3 bg-primary text-on-primary rounded-full font-headline-md text-body-md hover:bg-primary-container transition-all active:scale-95 shadow-lg shadow-primary/25">
                Devam Et
            </button>
</div>
</footer>
{/*  Suppressed Shell Components (BottomNavBar / NavigationDrawer) as per 'Destination' Rule for transactional flows  */}

    </motion.div>
  );
}
