import React from 'react';
import { motion } from 'framer-motion';
import { useNavigate, useParams } from 'react-router-dom';

const jobDetails = {
  "1": {
    title: "Frontend Developer",
    company: "Tech Solutions",
    location: "İstanbul (Hibrit)",
    type: "Tam Zamanlı",
    match: "%92",
    description: "Modern web teknolojileri ile kullanıcı dostu arayüzler geliştirecek, React ekosistemine hakim çalışma arkadaşları arıyoruz.",
    skills: {
      technical: 85,
      social: 70,
      experience: 90
    }
  }
};

export default function JobDetail() {
  const navigate = useNavigate();
  const { id } = useParams();
  const job = jobDetails[id] || jobDetails["1"];

  return (
    <motion.div 
      initial={{ x: 300, opacity: 0 }}
      animate={{ x: 0, opacity: 1 }}
      exit={{ x: -300, opacity: 0 }}
      className="bg-surface min-h-full flex flex-col"
    >
      <header className="sticky top-0 z-50 bg-white/80 backdrop-blur-md px-margin-mobile py-4 border-b border-outline-variant flex items-center gap-4">
        <button onClick={() => navigate('/kesfet')} className="text-primary active:scale-90 transition-transform">
          <span className="material-symbols-outlined">arrow_back</span>
        </button>
        <h1 className="font-headline-md text-[18px] text-on-surface truncate">{job.title}</h1>
      </header>

      <main className="p-margin-mobile space-y-6 pb-24">
        <section className="bg-white rounded-3xl p-6 border border-outline-variant shadow-sm text-center relative overflow-hidden">
          <div className="w-20 h-20 bg-surface-container rounded-2xl mx-auto mb-4 flex items-center justify-center">
             <span className="material-symbols-outlined text-primary text-[40px]">apartment</span>
          </div>
          <h2 className="font-headline-lg text-headline-md mb-1">{job.title}</h2>
          <p className="text-primary font-medium mb-4">{job.company}</p>
          
          <div className="flex justify-center gap-4 text-outline text-[12px]">
            <span className="flex items-center gap-1"><span className="material-symbols-outlined text-[16px]">location_on</span> {job.location}</span>
            <span className="flex items-center gap-1"><span className="material-symbols-outlined text-[16px]">work</span> {job.type}</span>
          </div>
        </section>

        <section className="bg-white rounded-3xl p-6 border border-outline-variant shadow-sm">
          <h3 className="font-label-bold text-outline uppercase tracking-widest text-[10px] mb-4">Yetkinlik Ağırlığı</h3>
          <div className="grid grid-cols-3 gap-2">
            <div className="text-center">
              <div className="text-headline-md text-primary">{job.skills.technical}%</div>
              <div className="text-[10px] text-outline font-bold">TEKNİK</div>
            </div>
            <div className="text-center border-x border-outline-variant">
              <div className="text-headline-md text-tertiary">{job.skills.social}%</div>
              <div className="text-[10px] text-outline font-bold">SOSYAL</div>
            </div>
            <div className="text-center">
              <div className="text-headline-md text-secondary">{job.skills.experience}%</div>
              <div className="text-[10px] text-outline font-bold">DENEYİM</div>
            </div>
          </div>
          <div className="mt-4 h-1.5 w-full bg-surface-container rounded-full overflow-hidden flex">
             <div style={{ width: `${job.skills.technical}%` }} className="bg-primary h-full"></div>
             <div style={{ width: `${job.skills.social}%` }} className="bg-tertiary h-full"></div>
             <div style={{ width: `${job.skills.experience}%` }} className="bg-secondary h-full"></div>
          </div>
        </section>

        <section className="bg-white rounded-3xl p-6 border border-outline-variant shadow-sm">
          <h3 className="font-headline-md text-[18px] mb-3">İş Tanımı</h3>
          <p className="text-body-sm text-on-surface-variant leading-relaxed">
            {job.description}
          </p>
        </section>
      </main>

      <footer className="sticky bottom-0 bg-white/90 backdrop-blur-xl p-margin-mobile border-t border-outline-variant shrink-0 z-50">
        <button className="w-full bg-primary text-on-primary py-4 rounded-2xl font-label-bold text-body-md shadow-lg shadow-primary/20 active:scale-95 transition-transform">
          Hemen Başvur
        </button>
      </footer>
    </motion.div>
  );
}
