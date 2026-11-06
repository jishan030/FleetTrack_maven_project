import { useEffect, useState } from 'react';
import { checkBackendHealth } from './services/api';
import './App.css';

function App() {
  const [status, setStatus] = useState('Checking...');
  const [active, setActive] = useState('Dashboard');

  useEffect(() => {
    checkBackendHealth()
      .then(() => setStatus('Online'))
      .catch(() => setStatus('Offline'));
  }, []);

  const menu = ['Dashboard', 'Vehicles', 'Drivers', 'Trips', 'Maintenance'];

  return (
    <div className="layout">

      <aside className="sidebar">
        <h2>FleetTrack<span>.</span></h2>
        <p className="subtitle">FLEET MANAGEMENT</p>

        <nav>
          {menu.map(item => (
            <button
              key={item}
              className={active === item ? 'active' : ''}
              onClick={() => setActive(item)}
            >
              {item}
            </button>
          ))}
        </nav>

        <div className="sidebar-bottom">
          <span>Infrastructure Status</span>
          <strong className="online-dot">● {status}</strong>
        </div>
      </aside>

      <main className="main">

        <header>
          <div>
            <h1>{active}</h1>
            <p>Fleet management overview and operations</p>
          </div>

          <div className="admin">
            <span>Administrator</span>
            <div className="avatar">JK</div>
          </div>
        </header>

        {active === 'Dashboard' ? (
          <>
            <section className="welcome">
              <div>
                <h2>Welcome to FleetTrack</h2>
                <p>Monitor your fleet operations from one place.</p>
              </div>
              <span>LIVE OVERVIEW</span>
            </section>

            <section className="stats">
              <div className="card">
                <span>Total Vehicles</span>
                <h2>48</h2>
                <small>Registered vehicles</small>
              </div>

              <div className="card">
                <span>Active Drivers</span>
                <h2>32</h2>
                <small>Available drivers</small>
              </div>

              <div className="card">
                <span>Active Trips</span>
                <h2>12</h2>
                <small>Currently running</small>
              </div>

              <div className="card">
                <span>Maintenance</span>
                <h2>04</h2>
                <small>Vehicles under service</small>
              </div>
            </section>

            <section className="content-grid">

              <div className="panel">
                <h3>Recent Fleet Activity</h3>

                <div className="activity">
                  <span className="green">●</span>
                  <div>
                    <strong>Vehicle FL-102</strong>
                    <p>Trip started successfully</p>
                  </div>
                  <small>10 min ago</small>
                </div>

                <div className="activity">
                  <span className="green">●</span>
                  <div>
                    <strong>Vehicle FL-108</strong>
                    <p>Trip completed</p>
                  </div>
                  <small>30 min ago</small>
                </div>

                <div className="activity">
                  <span className="orange">●</span>
                  <div>
                    <strong>Vehicle FL-115</strong>
                    <p>Maintenance scheduled</p>
                  </div>
                  <small>1 hour ago</small>
                </div>
              </div>

              <div className="panel">
                <h3>System Health</h3>

                <div className="health">
                  <span>Frontend</span>
                  <strong className="green">● Running</strong>
                </div>

                <div className="health">
                  <span>Spring Boot API</span>
                  <strong className={status === 'Online' ? 'green' : 'orange'}>
                    ● {status}
                  </strong>
                </div>

                <div className="health">
                  <span>Application Port</span>
                  <strong>8080</strong>
                </div>
              </div>

            </section>
          </>
        ) : (
          <section className="panel">
            <h3>{active} Management</h3>
            <p>This module will be connected to Spring Boot REST APIs.</p>
          </section>
        )}

        <footer>FleetTrack © 2026 | Fleet Management Platform</footer>

      </main>
    </div>
  );
}

export default App;