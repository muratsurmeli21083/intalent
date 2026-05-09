import React from 'react';
import { BrowserRouter as Router, Routes, Route, useLocation } from 'react-router-dom';
import { AnimatePresence } from 'framer-motion';

import GiriYapStitch from './GiriYapStitch';
import ProfilBilgileriniDoldur from './ProfilBilgileriniDoldur';
import TercihleriniBelirle from './TercihleriniBelirle';
import ProfilVeLiveCv from './ProfilVeLiveCv';
import KesfetJobLists from './KesfetJobLists';
import JobDetail from './JobDetail';
import GelisimTasks from './GelisimTasks';

function AnimatedRoutes() {
  const location = useLocation();
  
  return (
    <AnimatePresence mode="wait">
      <Routes location={location} key={location.pathname}>
        <Route path="/" element={<GiriYapStitch />} />
        <Route path="/profil" element={<ProfilBilgileriniDoldur />} />
        <Route path="/tercihler" element={<TercihleriniBelirle />} />
        <Route path="/cv" element={<ProfilVeLiveCv />} />
        <Route path="/kesfet" element={<KesfetJobLists />} />
        <Route path="/job/:id" element={<JobDetail />} />
        <Route path="/gelisim" element={<GelisimTasks />} />
      </Routes>
    </AnimatePresence>
  );
}

export default function App() {
  return (
    <Router>
      <div className="mobile-frame">
        <div className="mobile-notch"></div>
        <div className="mobile-content">
          <AnimatedRoutes />
        </div>
      </div>
    </Router>
  );
}
