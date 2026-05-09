import React from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';

const jobs = [
  {
    id: 1,
    title: "Frontend Developer",
    company: "Tech Solutions",
    location: "İstanbul (Hibrit)",
    match: "%92",
    tags: ["React", "Tailwind", "Vite"]
  },
  {
    id: 2,
    title: "UI/UX Designer",
    company: "Creative Sync",
    location: "Uzaktan",
    match: "%88",
    tags: ["Figma", "Design System", "Mobile"]
  },
  {
    id: 3,
    title: "Product Manager",
    company: "Innovate Global",
    location: "Ankara",
    match: "%85",
    tags: ["Agile", "Product Strategy"]
  }
];

export default function KesfetJobLists() {
  const navigate = useNavigate();

  return (
    <motion.div 
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="bg-surface min-h-full flex flex-col"
    >
      <header className="sticky top-0 z-50 bg-white/80 backdrop-blur-md px-margin-mobile py-4 border-b border-outline-variant">
        <h1 className="font-headline-md text-headline-md text-on-surface">Keşfet</h1>
        <p className="text-body-sm text-on-surface-variant">Senin için en uygun fırsatlar</p>
      </header>

      <main className="p-margin-mobile space-y-4 pb-20">
        {jobs.map((job) => (
          <div 
            key={job.id}
            className="bg-white rounded-2xl p-4 border border-outline-variant shadow-sm hover:shadow-md transition-shadow cursor-pointer"
            onClick={() => navigate(`/job/${job.id}`)}
          >
            <div className="flex justify-between items-start mb-2">
              <div>
                <h3 className="font-headline-md text-[18px] text-on-surface">{job.title}</h3>
                <p className="text-body-sm text-primary font-medium">{job.company}</p>
              </div>
              <div className="bg-primary-container/20 text-primary px-2 py-1 rounded-full text-numeric-data font-bold">
                {job.match} Uyum
              </div>
            </div>
            
            <div className="flex items-center gap-2 text-outline text-[12px] mb-3">
              <span className="material-symbols-outlined text-[16px]">location_on</span>
              {job.location}
            </div>

            <div className="flex flex-wrap gap-2">
              {job.tags.map(tag => (
                <span key={tag} className="bg-surface-container px-2 py-1 rounded-md text-[11px] font-label-bold text-on-surface-variant uppercase tracking-wider">
                  {tag}
                </span>
              ))}
            </div>
          </div>
        ))}

        <div className="bg-inverse-surface rounded-2xl p-6 text-inverse-on-surface relative overflow-hidden mt-6">
          <div className="relative z-10">
            <h3 className="font-headline-md text-[18px] mb-2">Yapay Zeka Önerisi</h3>
            <p className="text-body-sm opacity-90 mb-4">Profilini güçlendirerek sana daha uygun %20 daha fazla eşleşme yakala!</p>
            <button 
              onClick={() => navigate('/profil')}
              className="bg-white text-on-background px-4 py-2 rounded-xl font-label-bold text-label-bold"
            >
              Profili Tamamla
            </button>
          </div>
          <div className="absolute top-0 right-0 w-32 h-32 bg-primary/20 blur-3xl rounded-full translate-x-1/2 -translate-y-1/2"></div>
        </div>
      </main>

      {/* Nav Placeholder */}
      <nav className="sticky bottom-0 w-full z-50 flex justify-around items-center px-2 h-16 bg-white/90 backdrop-blur-lg border-t border-outline-variant shrink-0">
        <button className="flex flex-col items-center justify-center text-primary active:scale-90">
          <span className="material-symbols-outlined" style={{ fontVariationSettings: "'FILL' 1" }}>explore</span>
          <span className="text-[10px] font-medium">Keşfet</span>
        </button>
        <button onClick={() => navigate('/cv')} className="flex flex-col items-center justify-center text-outline active:scale-90">
          <span className="material-symbols-outlined">person</span>
          <span className="text-[10px] font-medium">Profil</span>
        </button>
      </nav>
    </motion.div>
  );
}
