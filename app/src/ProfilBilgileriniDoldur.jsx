import React from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';

export default function ProfilBilgileriniDoldur() {
  const navigate = useNavigate();
  return (
    <motion.div 
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.3 }}
      className="bg-surface font-body-md text-on-surface min-h-full flex flex-col overflow-x-hidden w-full relative"
    >
        
{/*  Header Section  */}
<header className="w-full bg-white/80 backdrop-blur-md sticky top-0 z-50 px-margin-mobile h-16 flex items-center justify-between shrink-0">
<div className="flex items-center gap-2">
<img alt="intalent logo" className="h-6 w-auto object-contain" data-alt="A sleek and professional brand logo for a technology recruitment company named intalent, featuring sharp geometric typography in a vibrant Electric Blue. The logo is displayed against a clean, white background with high-key lighting to emphasize a modern and trustworthy corporate identity. The visual style is minimalist and high-contrast, reflecting precision and intelligence." src="https://lh3.googleusercontent.com/aida/ADBb0ugQJETThvuO9Zf1t_1lEQNiZAfC0DEL4qhntCvwQR7qjvQZe-GY_P2mIiLlQD28-PgJHagksgK3Hdm5wCiXUJ1HKWIkKmcPOyi1tMVDdEpSRYh8wdg07aSa0nWH-sQ3deHcPJIfC0de6zQ3i7blMkH8gw4fZThhfixtDwEe8tKQd_c0YBSnfhW-DwvAONW47zyVzfhBDJpL0Rk75I1IL5Q9YXZ79VLp-4kbzsTusVTOHA7Q4RnfnxfVDg"/>
</div>
<button onClick={() => navigate('/')} className="text-primary font-label-bold text-label-bold">Geri Dön</button>
</header>
{/*  Main Content Container  */}
<main className="w-full max-w-md px-margin-mobile flex-grow pb-32">
{/*  Progress Indicator  */}
<div className="mt-base">
<div className="flex justify-between items-center mb-xs">
<span className="text-label-bold font-label-bold text-outline uppercase tracking-widest">ADIM 3/4</span>
<span className="text-label-bold font-label-bold text-primary">75% Tamamlandı</span>
</div>
<div className="w-full h-1 bg-surface-container-highest rounded-full overflow-hidden">
<div className="h-full bg-primary w-3/4 rounded-full"></div>
</div>
</div>
{/*  Hero Title  */}
<div className="mt-lg mb-md">
<h1 className="font-headline-lg text-headline-lg text-on-surface tracking-tight">Profilini Güçlendir</h1>
<p className="font-body-sm text-body-sm text-on-surface-variant mt-xs">
                Yeteneklerini ve tecrübelerini ekleyerek Merit puanını artırabilirsin. Bu alanlar isteğe bağlıdır.
            </p>
</div>
{/*  Form Sections  */}
<div className="space-y-gutter">
{/*  Eğitim Section  */}
<section className="bg-white border border-outline-variant p-md rounded-xl shadow-sm">
<div className="flex justify-between items-center mb-sm">
<div className="flex items-center gap-base">
<span className="material-symbols-outlined text-primary" data-icon="school">school</span>
<h2 className="font-headline-md text-[18px]">Eğitim</h2>
</div>
<button className="flex items-center gap-xs text-primary font-label-bold text-label-bold py-1 px-3 bg-primary-fixed/30 rounded-full hover:bg-primary-fixed/50 transition-colors">
<span className="material-symbols-outlined text-[16px]" data-icon="add">add</span>
                        Ekle
                    </button>
</div>
<div className="space-y-sm">
<div className="group">
<label className="block text-label-bold font-label-bold text-outline mb-xs">Üniversite</label>
<input className="w-full bg-surface border-none border-b-2 border-transparent focus:border-primary focus:ring-0 rounded-lg p-sm font-body-sm text-body-sm transition-all placeholder:text-outline-variant" placeholder="Örn: İstanbul Teknik Üniversitesi" type="text"/>
</div>
<div className="group">
<label className="block text-label-bold font-label-bold text-outline mb-xs">Bölüm</label>
<input className="w-full bg-surface border-none border-b-2 border-transparent focus:border-primary focus:ring-0 rounded-lg p-sm font-body-sm text-body-sm transition-all placeholder:text-outline-variant" placeholder="Örn: Bilgisayar Mühendisliği" type="text"/>
</div>
</div>
</section>
{/*  Deneyim Section  */}
<section className="bg-white border border-outline-variant p-md rounded-xl shadow-sm">
<div className="flex justify-between items-center mb-sm">
<div className="flex items-center gap-base">
<span className="material-symbols-outlined text-primary" data-icon="work">work</span>
<h2 className="font-headline-md text-[18px]">Deneyim</h2>
</div>
<button className="flex items-center gap-xs text-primary font-label-bold text-label-bold py-1 px-3 bg-primary-fixed/30 rounded-full hover:bg-primary-fixed/50 transition-colors">
<span className="material-symbols-outlined text-[16px]" data-icon="add">add</span>
                        Ekle
                    </button>
</div>
<div className="space-y-sm">
<div className="group">
<label className="block text-label-bold font-label-bold text-outline mb-xs">Şirket</label>
<input className="w-full bg-surface border-none border-b-2 border-transparent focus:border-primary focus:ring-0 rounded-lg p-sm font-body-sm text-body-sm transition-all placeholder:text-outline-variant" placeholder="Örn: Tech Solutions Inc." type="text"/>
</div>
<div className="group">
<label className="block text-label-bold font-label-bold text-outline mb-xs">Pozisyon / Rol</label>
<input className="w-full bg-surface border-none border-b-2 border-transparent focus:border-primary focus:ring-0 rounded-lg p-sm font-body-sm text-body-sm transition-all placeholder:text-outline-variant" placeholder="Örn: Frontend Developer" type="text"/>
</div>
</div>
</section>
{/*  Sertifikalar Section  */}
<section className="bg-white border border-outline-variant p-md rounded-xl shadow-sm">
<div className="flex justify-between items-center mb-sm">
<div className="flex items-center gap-base">
<span className="material-symbols-outlined text-primary" data-icon="description">description</span>
<h2 className="font-headline-md text-[18px]">CV Yükle</h2>
</div>
</div>
<div className="flex items-center justify-center py-sm border-2 border-dashed border-outline-variant rounded-lg bg-surface-container-lowest"><div className="text-center">
<span className="material-symbols-outlined text-outline text-[32px] mb-xs" data-icon="upload_file">upload_file</span>
<p className="font-body-sm text-body-sm text-outline-variant font-medium">CV veya özgeçmişini yükle</p>
<p className="text-[12px] text-outline opacity-70 mt-1">PDF, DOCX (Max. 5MB)</p>
</div></div>
</section>
{/*  Visual Merit Hint  */}
<div className="relative w-full h-32 rounded-xl overflow-hidden shadow-md">
<img className="absolute inset-0 w-full h-full object-cover" data-alt="A sophisticated data visualization background featuring subtle mesh gradients of Electric Blue and soft slate gray. Interconnected nodes and light trails flow across the frame, suggesting a network of talent and data-driven verification. The lighting is ethereal and cool-toned, creating a high-tech lab atmosphere that feels professional and innovative." src="https://lh3.googleusercontent.com/aida/ADBb0ug2yPqmglL8d57hsS0iRjQq3e35jVwh94NUUkYZ9_5ugT6AlLaJ9zYOPPDBHqF7HFygYimEr8g3SFARrAlQUQtvJ7ulSg2vP-BnL_9OT9KyGulZNBqe5pdFwrRedWDphfWfHsfDLdVJf5kUy2CVMF_CXnHI9d7NujpsJtpW0rPefP_u_Kdq699qd_bTAUvVCs327uJa75c7Lu3VLb6PPWEcG2ULBghx6eGSqpIIKbt0RuoO_yas2WHWziY51WHq2jlTisL9M5GkNQ"/>
<div className="absolute inset-0 bg-primary/20 backdrop-blur-[2px] flex items-center p-md">
<div className="text-white">
<span className="font-label-bold text-label-bold uppercase opacity-80">Merit İpucu</span>
<p className="font-body-sm text-body-sm font-medium">Sertifikalarını eklemek Merit skorunu %15 oranında yükseltebilir.</p>
</div>
</div>
</div>
</div>
</main>
{/*  Fixed Action Footer  */}
<footer className="sticky bottom-0 left-0 right-0 w-full bg-white/90 backdrop-blur-xl p-margin-mobile space-y-sm z-50 shadow-[0_-4px_20px_0_rgba(0,0,0,0.05)] border-t border-surface-container shrink-0">
<button onClick={() => navigate('/tercihler')} className="w-full bg-primary text-on-primary font-label-bold text-body-md py-4 rounded-xl shadow-lg shadow-primary/20 active:scale-[0.98] transition-transform">
            Devam Et
        </button>
<button className="w-full text-outline font-label-bold text-label-bold py-2 hover:text-primary transition-colors">
            Şimdilik Atla
        </button>
</footer>

    </motion.div>
  );
}
