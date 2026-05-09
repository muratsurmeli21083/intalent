import React from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';

const tasks = [
  { id: 1, title: "LinkedIn Profilini Optimize Et", type: "Core", time: "15 Dakika", icon: "share", color: "bg-blue-50 text-blue-600" },
  { id: 2, title: "React Test Yazımı Pratiği", type: "Expertise", time: "45 Dakika", icon: "code", color: "bg-green-50 text-green-600" },
  { id: 3, title: "Merit Analizini Tamamla", type: "Core", time: "10 Dakika", icon: "analytics", color: "bg-purple-50 text-purple-600" }
];

export default function GelisimTasks() {
  const navigate = useNavigate();

  return (
    <motion.div 
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="bg-surface min-h-full flex flex-col"
    >
      <header className="sticky top-0 z-50 bg-white/80 backdrop-blur-md px-margin-mobile py-4 border-b border-outline-variant">
        <h1 className="font-headline-md text-headline-md text-on-surface uppercase tracking-tight">Gelişim</h1>
        <p className="text-body-sm text-on-surface-variant">Liyakat skorunu yükseltmek için öneriler</p>
      </header>

      <main className="p-margin-mobile space-y-6 pb-24">
        <section className="bg-white rounded-3xl p-6 border border-outline-variant shadow-sm text-center">
          <div className="flex justify-between items-center mb-6">
             <div className="text-left">
                <div className="text-[10px] font-bold text-outline uppercase tracking-widest mb-1">Global Liyakat</div>
                <div className="text-headline-lg text-primary font-bold">TEST %85</div>
             </div>
             <div className="w-16 h-16 rounded-full border-4 border-primary/20 border-t-primary flex items-center justify-center">
                <span className="text-numeric-data font-bold">%85</span>
             </div>
          </div>
          <p className="text-body-sm text-on-surface-variant text-left">Gelişim görevlerini tamamlayarak liyakat skorunu %15 oranında artırabilirsin.</p>
        </section>

        <section className="space-y-4">
          <h3 className="font-label-bold text-outline uppercase tracking-widest text-[10px]">Bugünkü Görevlerin</h3>
          {tasks.map(task => (
            <div key={task.id} className="bg-white p-4 rounded-2xl border border-outline-variant flex items-center gap-4 shadow-sm active:scale-98 transition-transform cursor-pointer">
              <div className={`w-12 h-12 rounded-xl flex items-center justify-center shrink-0 ${task.color}`}>
                <span className="material-symbols-outlined">{task.icon}</span>
              </div>
              <div className="flex-1">
                <h4 className="font-label-bold text-on-surface">{task.title}</h4>
                <div className="flex items-center gap-2 mt-1">
                  <span className="text-[10px] font-bold text-outline uppercase">{task.type}</span>
                  <span className="w-1 h-1 bg-outline rounded-full"></span>
                  <span className="text-[10px] text-outline">{task.time}</span>
                </div>
              </div>
              <span className="material-symbols-outlined text-outline">play_circle</span>
            </div>
          ))}
        </section>

        <section className="bg-white rounded-3xl p-6 border border-outline-variant shadow-sm">
           <h3 className="font-headline-md text-[18px] mb-4">AI Kariyer Mentoru</h3>
           <div className="bg-surface-container/50 rounded-2xl p-4 flex items-center gap-4 border border-primary/10">
              <div className="w-10 h-10 bg-primary rounded-full flex items-center justify-center text-white shrink-0">
                 <span className="material-symbols-outlined text-[20px]">psychology</span>
              </div>
              <div className="flex-1">
                 <p className="text-body-sm text-on-surface leading-tight">"Bugün hangi yetkinliğini geliştirelim?"</p>
              </div>
              <button className="bg-primary text-white p-2 rounded-xl active:scale-90">
                 <span className="material-symbols-outlined text-[20px]">send</span>
              </button>
           </div>
        </section>
      </main>

      <nav className="sticky bottom-0 w-full z-50 flex justify-around items-center px-2 h-16 bg-white/90 backdrop-blur-lg border-t border-outline-variant shrink-0">
        <button onClick={() => navigate('/kesfet')} className="flex flex-col items-center justify-center text-outline active:scale-90">
          <span className="material-symbols-outlined">explore</span>
          <span className="text-[10px] font-medium">Keşfet</span>
        </button>
        <button className="flex flex-col items-center justify-center text-primary active:scale-90">
          <span className="material-symbols-outlined" style={{ fontVariationSettings: "'FILL' 1" }}>stars</span>
          <span className="text-[10px] font-medium">Gelişim</span>
        </button>
        <button onClick={() => navigate('/cv')} className="flex flex-col items-center justify-center text-outline active:scale-90">
          <span className="material-symbols-outlined">person</span>
          <span className="text-[10px] font-medium">Profil</span>
        </button>
      </nav>
    </motion.div>
  );
}
