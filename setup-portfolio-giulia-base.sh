#!/usr/bin/env bash
set -euo pipefail

# Run this script from the root of portfolio-giulia.
# It overwrites index.html, the three i18n JSON files, CSS files, and JS i18n files.

mkdir -p assets/i18n css js

cat > index.html <<'EOF'
<!doctype html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="theme-color" content="#7352b7" />
    <meta name="description" content="Portfolio profesional de Giulia Cardarilli, psicóloga en formación clínica." />
    <title>Giulia Cardarilli | Psicología</title>

    <link rel="icon" href="favicon.svg" type="image/svg+xml" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&family=Playfair+Display:ital,wght@0,500;0,600;0,700;1,500;1,600&display=swap" rel="stylesheet" />

    <link rel="stylesheet" href="css/reset.css" />
    <link rel="stylesheet" href="css/variables.css" />
    <link rel="stylesheet" href="css/base.css" />
    <link rel="stylesheet" href="css/layout.css" />
    <link rel="stylesheet" href="css/components.css" />
    <link rel="stylesheet" href="css/sections.css" />
    <link rel="stylesheet" href="css/responsive.css" />
    <script type="module" src="js/main.js" defer></script>
  </head>

  <body>
    <a class="skip-link" href="#main-content" data-i18n="accessibility.skip">Saltar al contenido principal</a>

    <header class="site-header">
      <div class="container header-inner">
        <a class="brand" href="#inicio" aria-label="Giulia Cardarilli — Inicio">
          <span class="brand-mark" aria-hidden="true">G</span>
          <span class="brand-name">Giulia Cardarilli</span>
        </a>

        <nav class="site-nav" aria-label="Navegación principal" data-i18n-aria-label="accessibility.mainNav">
          <a href="#sobre-mi" data-i18n="navigation.about">Sobre mí</a>
          <a href="#experiencia" data-i18n="navigation.experience">Experiencia</a>
          <a href="#formacion" data-i18n="navigation.education">Formación</a>
          <a href="#contacto" data-i18n="navigation.contact">Contacto</a>
        </nav>

        <div class="header-actions">
          <label class="sr-only" for="language-select" data-i18n="language.label">Idioma</label>
          <select id="language-select" class="language-selector" aria-label="Cambiar idioma" data-i18n-aria-label="language.label">
            <option value="es">ES</option>
            <option value="it">IT</option>
            <option value="en">EN</option>
          </select>
          <a class="button button--small button--header" href="#contacto" data-i18n="navigation.contact">Contacto</a>
        </div>
      </div>
    </header>

    <main id="main-content">
      <section id="inicio" class="hero section">
        <div class="hero-orb hero-orb--one" aria-hidden="true"></div>
        <div class="hero-orb hero-orb--two" aria-hidden="true"></div>
        <div class="container hero-grid">
          <div class="hero-copy reveal">
            <p class="eyebrow" data-i18n="hero.eyebrow">Psicóloga en formación clínica</p>
            <h1 data-i18n="hero.title">Comprender nuestros vínculos también es una forma de cuidarnos.</h1>
            <p class="hero-description" data-i18n="hero.description">Soy Giulia Cardarilli, psicóloga en formación clínica, interesada en el apego, las relaciones y el bienestar emocional.</p>
            <div class="hero-actions">
              <a class="button button--primary" href="#sobre-mi" data-i18n="hero.primaryCta">Conoce mi perfil</a>
              <a class="text-link" href="#formacion">
                <span data-i18n="hero.secondaryCta">Ver formación</span>
                <span aria-hidden="true">↘</span>
              </a>
            </div>
          </div>

          <div class="hero-portrait reveal">
            <div class="portrait-frame">
              <img src="assets/images/profile/giulia-cardarilli.jpeg" alt="Giulia Cardarilli" data-i18n-alt="images.profileAlt" />
            </div>
            <div class="portrait-note">
              <span class="portrait-note__line" aria-hidden="true"></span>
              <p data-i18n="hero.note">Escucha, rigor y cercanía.</p>
            </div>
          </div>
        </div>
      </section>

      <section id="sobre-mi" class="section section--soft about">
        <div class="container two-column">
          <div class="section-heading reveal">
            <p class="eyebrow" data-i18n="about.eyebrow">Sobre mí</p>
            <h2 data-i18n="about.title">Una mirada cercana, rigurosa y humana.</h2>
          </div>
          <div class="about-copy reveal">
            <p data-i18n="about.paragraphOne">Mi interés profesional nace de la escucha y de la comprensión de las experiencias que dan forma a nuestra manera de relacionarnos.</p>
            <p data-i18n="about.paragraphTwo">Combino mi formación en Psicología con experiencia en entornos de alta responsabilidad, análisis y atención a personas. Valoro la empatía, la confidencialidad y el trabajo cuidadoso con cada realidad individual.</p>
            <div class="pill-list" aria-label="Valores profesionales" data-i18n-aria-label="about.valuesLabel">
              <span data-i18n="about.valueOne">Escucha activa</span>
              <span data-i18n="about.valueTwo">Empatía</span>
              <span data-i18n="about.valueThree">Rigor</span>
              <span data-i18n="about.valueFour">Responsabilidad</span>
            </div>
          </div>
        </div>
      </section>

      <section id="experiencia" class="section experience">
        <div class="container">
          <div class="section-heading section-heading--center reveal">
            <p class="eyebrow" data-i18n="experience.eyebrow">Experiencia</p>
            <h2 data-i18n="experience.title">Habilidades que acompañan mi perfil profesional.</h2>
            <p data-i18n="experience.intro">Una trayectoria desarrollada en contextos exigentes, con especial atención a las personas, la comunicación responsable y el análisis cuidadoso de la información.</p>
          </div>

          <div class="experience-grid">
            <article class="experience-card reveal">
              <p class="experience-card__date" data-i18n="experience.amlDate">2025 — Actualidad</p>
              <h3 data-i18n="experience.amlTitle">Análisis de perfiles complejos · AML/CFT</h3>
              <p class="experience-card__organisation">OPPLUS · Málaga</p>
              <p data-i18n="experience.amlDescription">Experiencia en análisis responsable de información sensible, gestión rigurosa de procesos y toma de decisiones en un entorno de alta exigencia.</p>
              <ul class="skill-list">
                <li data-i18n="experience.amlSkillOne">Confidencialidad y sentido ético</li>
                <li data-i18n="experience.amlSkillTwo">Atención al detalle</li>
                <li data-i18n="experience.amlSkillThree">Pensamiento analítico</li>
              </ul>
            </article>

            <article class="experience-card reveal">
              <p class="experience-card__date" data-i18n="experience.managerDate">2024 — Actualidad</p>
              <h3 data-i18n="experience.managerTitle">Gestión de clientes · BBVA Italia</h3>
              <p class="experience-card__organisation">OPPLUS · Málaga</p>
              <p data-i18n="experience.managerDescription">Atención y acompañamiento de personas en un contexto internacional, con una comunicación clara, cercana y adaptada a necesidades diversas.</p>
              <ul class="skill-list">
                <li data-i18n="experience.managerSkillOne">Comunicación intercultural</li>
                <li data-i18n="experience.managerSkillTwo">Escucha y orientación a la persona</li>
                <li data-i18n="experience.managerSkillThree">Resolución responsable de situaciones</li>
              </ul>
            </article>

            <article class="experience-card experience-card--accent reveal">
              <p class="experience-card__date" data-i18n="experience.profileDate">Perfil profesional</p>
              <h3 data-i18n="experience.profileTitle">Competencias transferibles</h3>
              <p data-i18n="experience.profileDescription">La coordinación, la formación interna y el trabajo en equipo han reforzado una forma de trabajar proactiva, organizada y sensible a las necesidades individuales.</p>
              <ul class="skill-list">
                <li data-i18n="experience.profileSkillOne">Trabajo colaborativo</li>
                <li data-i18n="experience.profileSkillTwo">Organización y compromiso</li>
                <li data-i18n="experience.profileSkillThree">Acompañamiento respetuoso</li>
              </ul>
            </article>
          </div>
        </div>
      </section>

      <section id="formacion" class="section section--soft education">
        <div class="container">
          <div class="section-heading reveal">
            <p class="eyebrow" data-i18n="education.eyebrow">Formación</p>
            <h2 data-i18n="education.title">Aprendizaje continuo.</h2>
          </div>

          <div class="timeline">
            <article class="timeline-item reveal">
              <span class="timeline-item__dot" aria-hidden="true"></span>
              <div>
                <p class="timeline-item__period" data-i18n="education.masterStatus">En curso</p>
                <h3 data-i18n="education.masterTitle">Máster en Psicología Clínica</h3>
                <p data-i18n="education.masterDescription">Formación avanzada orientada a ampliar conocimientos y herramientas dentro del ámbito de la psicología clínica.</p>
              </div>
            </article>

            <article class="timeline-item reveal">
              <span class="timeline-item__dot" aria-hidden="true"></span>
              <div>
                <p class="timeline-item__period" data-i18n="education.degreePeriod">2016 — 2020</p>
                <h3 data-i18n="education.degreeTitle">Grado en Psicología</h3>
                <p data-i18n="education.degreeInstitution">Universidad de Málaga</p>
              </div>
            </article>

            <article class="timeline-item reveal">
              <span class="timeline-item__dot" aria-hidden="true"></span>
              <div>
                <p class="timeline-item__period" data-i18n="education.philosophyPeriod">2022 — 2026</p>
                <h3 data-i18n="education.philosophyTitle">Estudios de Filosofía</h3>
                <p data-i18n="education.philosophyInstitution">Universidad Nacional de Educación a Distancia (UNED)</p>
              </div>
            </article>
          </div>

          <article class="certificate-card reveal">
            <div class="certificate-card__copy">
              <p class="eyebrow" data-i18n="education.complementaryLabel">Formación complementaria</p>
              <h3 data-i18n="education.attachmentTitle">Curso sobre Apego Adulto: de nuestros vínculos a nuestras relaciones</h3>
              <p class="certificate-card__meta" data-i18n="education.attachmentMeta">AEPSIS · 20 horas lectivas · Septiembre de 2026</p>
              <p data-i18n="education.attachmentDescription">Formación orientada a comprender el apego adulto y su influencia en la forma en que construimos y vivimos nuestras relaciones.</p>
              <a class="text-link" href="assets/images/certificates/curso-apego-adulto-aepsis.jpeg" target="_blank" rel="noreferrer">
                <span data-i18n="education.certificateCta">Ver acreditación</span>
                <span aria-hidden="true">↗</span>
              </a>
            </div>
            <img class="certificate-card__image" src="assets/images/certificates/curso-apego-adulto-aepsis.jpeg" alt="Certificado del curso sobre apego adulto de AEPSIS" data-i18n-alt="images.certificateAlt" />
          </article>
        </div>
      </section>

      <section id="contacto" class="section contact">
        <div class="container contact-panel reveal">
          <div>
            <p class="eyebrow" data-i18n="contact.eyebrow">Contacto</p>
            <h2 data-i18n="contact.title">Construyamos una conversación.</h2>
            <p data-i18n="contact.description">Para colaboraciones, proyectos o contacto profesional, puedes encontrarme en LinkedIn.</p>
          </div>
          <div class="contact-panel__actions">
            <a class="button button--primary" href="https://www.linkedin.com/in/giulia-cardarilli-53b72a1b1" target="_blank" rel="noreferrer">LinkedIn <span aria-hidden="true">↗</span></a>
            <a class="button button--secondary" href="assets/documents/cv-giulia-cardarilli-es.pdf" data-cv-link download>
              <span data-i18n="contact.cvCta">Descargar CV</span>
              <span aria-hidden="true">↓</span>
            </a>
          </div>
        </div>
      </section>
    </main>

    <footer class="site-footer">
      <div class="container footer-inner">
        <p>© <span id="current-year"></span> Giulia Cardarilli. <span data-i18n="footer.rights">Todos los derechos reservados.</span></p>
        <p data-i18n="footer.disclaimer">Este sitio presenta un perfil profesional y formativo. No ofrece atención psicológica ni constituye una consulta clínica.</p>
      </div>
    </footer>
  </body>
</html>
EOF

cat > assets/i18n/es.json <<'EOF'
{
  "meta": {"title": "Giulia Cardarilli | Psicología", "description": "Portfolio profesional de Giulia Cardarilli, psicóloga en formación clínica."},
  "accessibility": {"skip": "Saltar al contenido principal", "mainNav": "Navegación principal"},
  "language": {"label": "Idioma"},
  "navigation": {"about": "Sobre mí", "experience": "Experiencia", "education": "Formación", "contact": "Contacto"},
  "images": {"profileAlt": "Retrato de Giulia Cardarilli", "certificateAlt": "Certificado del curso sobre apego adulto de AEPSIS"},
  "hero": {"eyebrow": "Psicóloga en formación clínica", "title": "Comprender nuestros vínculos también es una forma de cuidarnos.", "description": "Soy Giulia Cardarilli, psicóloga en formación clínica, interesada en el apego, las relaciones y el bienestar emocional.", "primaryCta": "Conoce mi perfil", "secondaryCta": "Ver formación", "note": "Escucha, rigor y cercanía."},
  "about": {"eyebrow": "Sobre mí", "title": "Una mirada cercana, rigurosa y humana.", "paragraphOne": "Mi interés profesional nace de la escucha y de la comprensión de las experiencias que dan forma a nuestra manera de relacionarnos.", "paragraphTwo": "Combino mi formación en Psicología con experiencia en entornos de alta responsabilidad, análisis y atención a personas. Valoro la empatía, la confidencialidad y el trabajo cuidadoso con cada realidad individual.", "valuesLabel": "Valores profesionales", "valueOne": "Escucha activa", "valueTwo": "Empatía", "valueThree": "Rigor", "valueFour": "Responsabilidad"},
  "experience": {"eyebrow": "Experiencia", "title": "Habilidades que acompañan mi perfil profesional.", "intro": "Una trayectoria desarrollada en contextos exigentes, con especial atención a las personas, la comunicación responsable y el análisis cuidadoso de la información.", "amlDate": "2025 — Actualidad", "amlTitle": "Análisis de perfiles complejos · AML/CFT", "amlDescription": "Experiencia en análisis responsable de información sensible, gestión rigurosa de procesos y toma de decisiones en un entorno de alta exigencia.", "amlSkillOne": "Confidencialidad y sentido ético", "amlSkillTwo": "Atención al detalle", "amlSkillThree": "Pensamiento analítico", "managerDate": "2024 — Actualidad", "managerTitle": "Gestión de clientes · BBVA Italia", "managerDescription": "Atención y acompañamiento de personas en un contexto internacional, con una comunicación clara, cercana y adaptada a necesidades diversas.", "managerSkillOne": "Comunicación intercultural", "managerSkillTwo": "Escucha y orientación a la persona", "managerSkillThree": "Resolución responsable de situaciones", "profileDate": "Perfil profesional", "profileTitle": "Competencias transferibles", "profileDescription": "La coordinación, la formación interna y el trabajo en equipo han reforzado una forma de trabajar proactiva, organizada y sensible a las necesidades individuales.", "profileSkillOne": "Trabajo colaborativo", "profileSkillTwo": "Organización y compromiso", "profileSkillThree": "Acompañamiento respetuoso"},
  "education": {"eyebrow": "Formación", "title": "Aprendizaje continuo.", "masterStatus": "En curso", "masterTitle": "Máster en Psicología Clínica", "masterDescription": "Formación avanzada orientada a ampliar conocimientos y herramientas dentro del ámbito de la psicología clínica.", "degreePeriod": "2016 — 2020", "degreeTitle": "Grado en Psicología", "degreeInstitution": "Universidad de Málaga", "philosophyPeriod": "2022 — 2026", "philosophyTitle": "Estudios de Filosofía", "philosophyInstitution": "Universidad Nacional de Educación a Distancia (UNED)", "complementaryLabel": "Formación complementaria", "attachmentTitle": "Curso sobre Apego Adulto: de nuestros vínculos a nuestras relaciones", "attachmentMeta": "AEPSIS · 20 horas lectivas · Septiembre de 2026", "attachmentDescription": "Formación orientada a comprender el apego adulto y su influencia en la forma en que construimos y vivimos nuestras relaciones.", "certificateCta": "Ver acreditación"},
  "contact": {"eyebrow": "Contacto", "title": "Construyamos una conversación.", "description": "Para colaboraciones, proyectos o contacto profesional, puedes encontrarme en LinkedIn.", "cvCta": "Descargar CV"},
  "footer": {"rights": "Todos los derechos reservados.", "disclaimer": "Este sitio presenta un perfil profesional y formativo. No ofrece atención psicológica ni constituye una consulta clínica."}
}
EOF

cat > assets/i18n/it.json <<'EOF'
{
  "meta": {"title": "Giulia Cardarilli | Psicologia", "description": "Portfolio professionale di Giulia Cardarilli, psicologa in formazione clinica."},
  "accessibility": {"skip": "Vai al contenuto principale", "mainNav": "Navigazione principale"},
  "language": {"label": "Lingua"},
  "navigation": {"about": "Chi sono", "experience": "Esperienza", "education": "Formazione", "contact": "Contatti"},
  "images": {"profileAlt": "Ritratto di Giulia Cardarilli", "certificateAlt": "Attestato del corso sull'attaccamento adulto di AEPSIS"},
  "hero": {"eyebrow": "Psicologa in formazione clinica", "title": "Comprendere i nostri legami è anche un modo per prenderci cura di noi.", "description": "Sono Giulia Cardarilli, psicologa in formazione clinica, interessata all'attaccamento, alle relazioni e al benessere emotivo.", "primaryCta": "Scopri il mio profilo", "secondaryCta": "Vedi la formazione", "note": "Ascolto, rigore e vicinanza."},
  "about": {"eyebrow": "Chi sono", "title": "Uno sguardo vicino, rigoroso e umano.", "paragraphOne": "Il mio interesse professionale nasce dall'ascolto e dalla comprensione delle esperienze che danno forma al nostro modo di relazionarci.", "paragraphTwo": "Unisco la mia formazione in Psicologia all'esperienza in contesti ad alta responsabilità, analisi e relazione con le persone. Valorizzo l'empatia, la riservatezza e un lavoro attento a ogni realtà individuale.", "valuesLabel": "Valori professionali", "valueOne": "Ascolto attivo", "valueTwo": "Empatia", "valueThree": "Rigore", "valueFour": "Responsabilità"},
  "experience": {"eyebrow": "Esperienza", "title": "Competenze che accompagnano il mio profilo professionale.", "intro": "Un percorso sviluppato in contesti complessi, con particolare attenzione alle persone, alla comunicazione responsabile e all'analisi accurata delle informazioni.", "amlDate": "2025 — Oggi", "amlTitle": "Analisi di profili complessi · AML/CFT", "amlDescription": "Esperienza nell'analisi responsabile di informazioni sensibili, nella gestione rigorosa dei processi e nel processo decisionale in un contesto molto esigente.", "amlSkillOne": "Riservatezza e senso etico", "amlSkillTwo": "Attenzione ai dettagli", "amlSkillThree": "Pensiero analitico", "managerDate": "2024 — Oggi", "managerTitle": "Gestione clienti · BBVA Italia", "managerDescription": "Assistenza e accompagnamento delle persone in un contesto internazionale, attraverso una comunicazione chiara, attenta e adattata a esigenze diverse.", "managerSkillOne": "Comunicazione interculturale", "managerSkillTwo": "Ascolto e attenzione alla persona", "managerSkillThree": "Gestione responsabile delle situazioni", "profileDate": "Profilo professionale", "profileTitle": "Competenze trasversali", "profileDescription": "Il coordinamento, la formazione interna e il lavoro di squadra hanno consolidato un modo di lavorare proattivo, organizzato e sensibile ai bisogni individuali.", "profileSkillOne": "Lavoro collaborativo", "profileSkillTwo": "Organizzazione e impegno", "profileSkillThree": "Accompagnamento rispettoso"},
  "education": {"eyebrow": "Formazione", "title": "Apprendimento continuo.", "masterStatus": "In corso", "masterTitle": "Master in Psicologia Clinica", "masterDescription": "Formazione avanzata volta ad approfondire conoscenze e strumenti nell'ambito della psicologia clinica.", "degreePeriod": "2016 — 2020", "degreeTitle": "Laurea in Psicologia", "degreeInstitution": "Università di Malaga", "philosophyPeriod": "2022 — 2026", "philosophyTitle": "Studi in Filosofia", "philosophyInstitution": "Universidad Nacional de Educación a Distancia (UNED)", "complementaryLabel": "Formazione complementare", "attachmentTitle": "Corso sull'attaccamento adulto: dai nostri legami alle nostre relazioni", "attachmentMeta": "AEPSIS · 20 ore formative · Settembre 2026", "attachmentDescription": "Formazione dedicata alla comprensione dell'attaccamento adulto e della sua influenza sul modo in cui costruiamo e viviamo le relazioni.", "certificateCta": "Vedi attestato"},
  "contact": {"eyebrow": "Contatti", "title": "Costruiamo una conversazione.", "description": "Per collaborazioni, progetti o contatti professionali, puoi trovarmi su LinkedIn.", "cvCta": "Scarica il CV"},
  "footer": {"rights": "Tutti i diritti riservati.", "disclaimer": "Questo sito presenta un profilo professionale e formativo. Non offre assistenza psicologica né costituisce uno studio clinico."}
}
EOF

cat > assets/i18n/en.json <<'EOF'
{
  "meta": {"title": "Giulia Cardarilli | Psychology", "description": "Professional portfolio of Giulia Cardarilli, a psychologist in clinical training."},
  "accessibility": {"skip": "Skip to main content", "mainNav": "Main navigation"},
  "language": {"label": "Language"},
  "navigation": {"about": "About", "experience": "Experience", "education": "Education", "contact": "Contact"},
  "images": {"profileAlt": "Portrait of Giulia Cardarilli", "certificateAlt": "AEPSIS adult attachment course certificate"},
  "hero": {"eyebrow": "Psychologist in clinical training", "title": "Understanding our bonds is also a way of caring for ourselves.", "description": "I am Giulia Cardarilli, a psychologist in clinical training, interested in attachment, relationships and emotional wellbeing.", "primaryCta": "Discover my profile", "secondaryCta": "View education", "note": "Listening, rigour and care."},
  "about": {"eyebrow": "About me", "title": "A thoughtful, rigorous and human perspective.", "paragraphOne": "My professional interest is rooted in listening and in understanding the experiences that shape the way we relate to one another.", "paragraphTwo": "I combine my background in Psychology with experience in high-responsibility settings, analysis and people-facing work. I value empathy, confidentiality and a careful approach to each individual reality.", "valuesLabel": "Professional values", "valueOne": "Active listening", "valueTwo": "Empathy", "valueThree": "Rigour", "valueFour": "Responsibility"},
  "experience": {"eyebrow": "Experience", "title": "Skills that complement my professional profile.", "intro": "A career developed in demanding environments, with particular attention to people, responsible communication and the careful analysis of information.", "amlDate": "2025 — Present", "amlTitle": "Complex profile analysis · AML/CFT", "amlDescription": "Experience in the responsible analysis of sensitive information, rigorous process management and decision-making in a high-demand environment.", "amlSkillOne": "Confidentiality and ethical awareness", "amlSkillTwo": "Attention to detail", "amlSkillThree": "Analytical thinking", "managerDate": "2024 — Present", "managerTitle": "Client management · BBVA Italy", "managerDescription": "Supporting people in an international context through clear, approachable communication adapted to diverse needs.", "managerSkillOne": "Intercultural communication", "managerSkillTwo": "Listening and person-centred focus", "managerSkillThree": "Responsible problem-solving", "profileDate": "Professional profile", "profileTitle": "Transferable skills", "profileDescription": "Coordination, internal training and teamwork have strengthened a proactive, organised way of working that is attentive to individual needs.", "profileSkillOne": "Collaborative work", "profileSkillTwo": "Organisation and commitment", "profileSkillThree": "Respectful support"},
  "education": {"eyebrow": "Education", "title": "Continuous learning.", "masterStatus": "In progress", "masterTitle": "Master's Degree in Clinical Psychology", "masterDescription": "Advanced training to broaden knowledge and skills within the field of clinical psychology.", "degreePeriod": "2016 — 2020", "degreeTitle": "Bachelor's Degree in Psychology", "degreeInstitution": "University of Málaga", "philosophyPeriod": "2022 — 2026", "philosophyTitle": "Studies in Philosophy", "philosophyInstitution": "National University of Distance Education (UNED)", "complementaryLabel": "Further training", "attachmentTitle": "Adult Attachment: From Our Bonds to Our Relationships", "attachmentMeta": "AEPSIS · 20 teaching hours · September 2026", "attachmentDescription": "Training focused on understanding adult attachment and its influence on the way we build and experience relationships.", "certificateCta": "View certificate"},
  "contact": {"eyebrow": "Contact", "title": "Let's start a conversation.", "description": "For collaborations, projects or professional enquiries, you can find me on LinkedIn.", "cvCta": "Download CV"},
  "footer": {"rights": "All rights reserved.", "disclaimer": "This website presents a professional and educational profile. It does not offer psychological care or constitute a clinical practice."}
}
EOF

cat > css/reset.css <<'EOF'
*, *::before, *::after { box-sizing: border-box; }
html { -webkit-text-size-adjust: 100%; }
body, h1, h2, h3, p, ul { margin: 0; }
ul { padding: 0; }
img { display: block; max-width: 100%; }
button, input, select { font: inherit; }
a { color: inherit; text-decoration: none; }
EOF

cat > css/variables.css <<'EOF'
:root {
  --violet-950: #28163e;
  --violet-800: #49306a;
  --violet-700: #62428f;
  --violet-600: #7352b7;
  --violet-300: #cdbce9;
  --violet-150: #e9e1f6;
  --violet-100: #f2edfa;
  --violet-50: #faf8fe;
  --ink: #292431;
  --muted: #6d6476;
  --white: #ffffff;
  --line: #e7e0ec;
  --font-display: "Playfair Display", Georgia, serif;
  --font-body: "DM Sans", Arial, sans-serif;
  --container: 1160px;
  --radius-sm: 0.75rem;
  --radius-md: 1.25rem;
  --radius-lg: 2rem;
  --shadow: 0 1.25rem 3.5rem rgba(55, 28, 92, 0.1);
  --transition: 180ms ease;
}
EOF

cat > css/base.css <<'EOF'
html { scroll-behavior: smooth; }
body { color: var(--ink); background: var(--white); font-family: var(--font-body); font-size: 1rem; line-height: 1.65; }
h1, h2, h3 { font-family: var(--font-display); font-weight: 600; line-height: 1.08; letter-spacing: -0.035em; }
h1 { max-width: 12ch; font-size: clamp(3rem, 7vw, 5.85rem); }
h2 { max-width: 16ch; font-size: clamp(2.25rem, 4.5vw, 4rem); }
h3 { font-size: clamp(1.45rem, 2.3vw, 1.9rem); }
p { max-width: 68ch; }
a:focus-visible, select:focus-visible { outline: 3px solid rgba(115, 82, 183, .42); outline-offset: 4px; }
.sr-only { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); white-space: nowrap; border: 0; }
.skip-link { position: fixed; top: 1rem; left: 1rem; z-index: 100; transform: translateY(-200%); padding: .7rem 1rem; color: var(--white); background: var(--violet-800); border-radius: var(--radius-sm); }
.skip-link:focus { transform: translateY(0); }
EOF

cat > css/layout.css <<'EOF'
.container { width: min(var(--container), calc(100% - 3rem)); margin-inline: auto; }
.section { position: relative; padding-block: clamp(5rem, 10vw, 9rem); overflow: clip; }
.section--soft { background: var(--violet-50); }
.two-column { display: grid; grid-template-columns: minmax(0, .9fr) minmax(0, 1.1fr); gap: clamp(2rem, 9vw, 9rem); align-items: start; }
.site-header { position: sticky; top: 0; z-index: 20; border-bottom: 1px solid transparent; background: rgba(255,255,255,.84); backdrop-filter: blur(16px); }
.header-inner { min-height: 5.25rem; display: flex; align-items: center; justify-content: space-between; gap: 1.5rem; }
.brand, .header-actions, .site-nav, .hero-actions, .footer-inner, .contact-panel__actions { display: flex; align-items: center; }
.brand { gap: .65rem; flex-shrink: 0; font-family: var(--font-display); font-size: 1.14rem; font-weight: 700; }
.brand-mark { display: grid; width: 2rem; height: 2rem; place-items: center; color: var(--white); background: var(--violet-600); border-radius: 50%; font-size: 1rem; }
.site-nav { gap: clamp(.7rem, 2vw, 1.75rem); color: var(--muted); font-size: .9rem; }
.site-nav a { transition: color var(--transition); }
.site-nav a:hover { color: var(--violet-700); }
.header-actions { gap: .75rem; }
.hero-grid { display: grid; grid-template-columns: 1.03fr .97fr; gap: clamp(2.5rem, 8vw, 8rem); align-items: center; min-height: 39rem; }
.hero-copy { position: relative; z-index: 1; }
.hero-description { margin-top: 1.6rem; color: var(--muted); font-size: clamp(1.05rem, 1.7vw, 1.23rem); }
.hero-actions { flex-wrap: wrap; gap: 1.4rem; margin-top: 2.25rem; }
.hero-portrait { position: relative; justify-self: end; width: min(100%, 28rem); }
.section-heading { margin-bottom: clamp(2.5rem, 5vw, 4.5rem); }
.section-heading--center { display: grid; justify-items: center; text-align: center; }
.section-heading--center p:last-child { margin-top: 1.15rem; color: var(--muted); }
.about-copy { color: var(--muted); font-size: 1.1rem; }
.about-copy p + p { margin-top: 1.2rem; }
.experience-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.25rem; }
.timeline { max-width: 51rem; margin-bottom: 4rem; border-left: 1px solid var(--violet-300); }
.timeline-item { position: relative; display: grid; grid-template-columns: 1.5rem 1fr; gap: 1.5rem; padding: 0 0 2.5rem 1.25rem; }
.timeline-item__dot { width: .8rem; height: .8rem; margin-top: .42rem; background: var(--violet-600); border: 3px solid var(--violet-100); border-radius: 50%; box-shadow: 0 0 0 1px var(--violet-600); }
.timeline-item__period, .experience-card__date { margin-bottom: .35rem; color: var(--violet-700); font-size: .8rem; font-weight: 700; letter-spacing: .08em; text-transform: uppercase; }
.site-footer { padding-block: 2rem; color: var(--muted); background: var(--violet-950); font-size: .84rem; }
.footer-inner { justify-content: space-between; gap: 2rem; color: #ddd3e9; }
.footer-inner p:last-child { max-width: 47rem; text-align: right; }
EOF

cat > css/components.css <<'EOF'
.eyebrow { margin-bottom: 1rem; color: var(--violet-700); font-size: .76rem; font-weight: 700; letter-spacing: .14em; text-transform: uppercase; }
.button { display: inline-flex; align-items: center; justify-content: center; gap: .55rem; min-height: 3.15rem; padding: .8rem 1.25rem; border: 1px solid transparent; border-radius: 999px; font-size: .94rem; font-weight: 700; transition: transform var(--transition), background var(--transition), border-color var(--transition); }
.button:hover { transform: translateY(-2px); }
.button--primary { color: var(--white); background: var(--violet-600); box-shadow: 0 .7rem 1.6rem rgba(98, 66, 143, .2); }
.button--primary:hover { background: var(--violet-800); }
.button--secondary { color: var(--violet-800); border-color: var(--violet-300); background: transparent; }
.button--secondary:hover { background: var(--violet-100); }
.button--small { min-height: 2.45rem; padding: .5rem .9rem; font-size: .82rem; }
.language-selector { min-height: 2.45rem; padding: .5rem .45rem; color: var(--violet-800); background: var(--violet-50); border: 1px solid var(--line); border-radius: 999px; cursor: pointer; font-size: .78rem; font-weight: 700; letter-spacing: .08em; }
.text-link { display: inline-flex; align-items: center; gap: .5rem; color: var(--violet-700); font-weight: 700; }
.text-link:hover { color: var(--violet-950); }
.text-link span:last-child { transition: transform var(--transition); }
.text-link:hover span:last-child { transform: translate(.15rem, -.15rem); }
.pill-list { display: flex; flex-wrap: wrap; gap: .65rem; margin-top: 2rem; }
.pill-list span { padding: .45rem .8rem; color: var(--violet-800); background: var(--white); border: 1px solid var(--violet-150); border-radius: 999px; font-size: .84rem; font-weight: 600; }
.portrait-frame { position: relative; overflow: hidden; aspect-ratio: 4 / 5; background: var(--violet-150); border-radius: 12rem 12rem var(--radius-md) var(--radius-md); box-shadow: var(--shadow); }
.portrait-frame::after { position: absolute; inset: 0; content: ""; background: linear-gradient(160deg, rgba(101, 68, 145, .08), transparent 50%); }
.portrait-frame img { width: 100%; height: 100%; object-fit: cover; object-position: center; }
.portrait-note { position: absolute; right: -2.5rem; bottom: 2rem; display: flex; align-items: center; gap: .8rem; max-width: 12rem; color: var(--violet-950); font-family: var(--font-display); font-size: 1.1rem; font-style: italic; line-height: 1.25; }
.portrait-note__line { width: 2.5rem; height: 1px; background: var(--violet-600); }
.experience-card { display: flex; flex-direction: column; min-height: 25rem; padding: 2rem; background: var(--white); border: 1px solid var(--line); border-radius: var(--radius-md); transition: transform var(--transition), box-shadow var(--transition); }
.experience-card:hover { transform: translateY(-.35rem); box-shadow: var(--shadow); }
.experience-card--accent { color: var(--violet-950); background: var(--violet-100); border-color: transparent; }
.experience-card__organisation { margin-top: .75rem; color: var(--violet-700); font-size: .88rem; font-weight: 600; }
.experience-card > p:not(.experience-card__date):not(.experience-card__organisation) { margin-top: 1.5rem; color: var(--muted); }
.skill-list { display: grid; gap: .65rem; margin-top: auto; padding-top: 1.75rem; list-style: none; color: var(--violet-800); font-size: .88rem; font-weight: 600; }
.skill-list li { display: flex; gap: .55rem; align-items: baseline; }
.skill-list li::before { content: "✦"; color: var(--violet-600); font-size: .65rem; }
.certificate-card { display: grid; grid-template-columns: 1.15fr .85fr; gap: 2rem; align-items: center; padding: clamp(1.4rem, 4vw, 3rem); background: var(--white); border: 1px solid var(--line); border-radius: var(--radius-lg); box-shadow: var(--shadow); }
.certificate-card__copy > p:not(.eyebrow):not(.certificate-card__meta) { margin-block: 1.25rem; color: var(--muted); }
.certificate-card__meta { margin-top: 1rem; color: var(--violet-700); font-size: .88rem; font-weight: 600; }
.certificate-card__image { width: 100%; max-height: 20rem; object-fit: cover; object-position: top; border: 1px solid var(--line); border-radius: var(--radius-sm); box-shadow: 0 .7rem 1.7rem rgba(55, 28, 92, .12); }
.contact-panel { display: flex; justify-content: space-between; align-items: end; gap: 2rem; padding: clamp(2rem, 5vw, 4rem); color: var(--white); background: var(--violet-950); border-radius: var(--radius-lg); }
.contact-panel .eyebrow { color: var(--violet-300); }
.contact-panel h2 { max-width: 12ch; }
.contact-panel p:not(.eyebrow) { margin-top: 1rem; color: #d8cde6; }
.contact-panel__actions { flex-wrap: wrap; justify-content: flex-end; gap: .75rem; }
.contact-panel .button--secondary { color: var(--white); border-color: rgba(255,255,255,.35); }
.contact-panel .button--secondary:hover { background: rgba(255,255,255,.1); }
EOF

cat > css/sections.css <<'EOF'
.hero { padding-top: clamp(3.5rem, 7vw, 7rem); background: linear-gradient(135deg, var(--white) 0%, var(--violet-50) 100%); }
.hero-orb { position: absolute; border-radius: 50%; filter: blur(1px); pointer-events: none; }
.hero-orb--one { top: 8%; left: -10rem; width: 21rem; height: 21rem; background: rgba(205,188,233,.3); }
.hero-orb--two { right: 3%; bottom: 2%; width: 12rem; height: 12rem; border: 1px solid var(--violet-150); }
.about { border-top: 1px solid var(--violet-100); }
.education { border-top: 1px solid var(--violet-100); }
.reveal { animation: rise-in .65s both; }
.experience-grid .reveal:nth-child(2) { animation-delay: .09s; }
.experience-grid .reveal:nth-child(3) { animation-delay: .18s; }
@keyframes rise-in { from { opacity: 0; transform: translateY(1.25rem); } to { opacity: 1; transform: translateY(0); } }
@media (prefers-reduced-motion: reduce) { html { scroll-behavior: auto; } *, *::before, *::after { animation-duration: .01ms !important; animation-iteration-count: 1 !important; transition-duration: .01ms !important; } }
EOF

cat > css/responsive.css <<'EOF'
@media (max-width: 860px) {
  .site-nav { display: none; }
  .hero-grid, .two-column, .certificate-card { grid-template-columns: 1fr; }
  .hero-grid { min-height: auto; }
  .hero-portrait { justify-self: start; width: min(100%, 25rem); }
  .portrait-note { right: -1.5rem; }
  .experience-grid { grid-template-columns: 1fr; }
  .experience-card { min-height: 0; }
  .skill-list { margin-top: 1rem; }
  .contact-panel { align-items: start; flex-direction: column; }
  .contact-panel__actions { justify-content: flex-start; }
  .footer-inner { align-items: start; flex-direction: column; }
  .footer-inner p:last-child { text-align: left; }
}
@media (max-width: 540px) {
  .container { width: min(var(--container), calc(100% - 2rem)); }
  .header-inner { min-height: 4.65rem; gap: .5rem; }
  .brand-name, .button--header { display: none; }
  .header-actions { margin-left: auto; }
  .hero { padding-top: 3.75rem; }
  .portrait-note { position: static; margin-top: 1rem; }
  .section { padding-block: 4.5rem; }
  .certificate-card { padding: 1.25rem; }
}
EOF

cat > js/i18n.js <<'EOF'
const supportedLanguages = ["es", "it", "en"];
const defaultLanguage = "es";

function getValue(object, path) {
  return path.split(".").reduce((value, key) => value?.[key], object);
}

function getInitialLanguage() {
  const fromUrl = new URLSearchParams(window.location.search).get("lang");
  const stored = localStorage.getItem("giulia-portfolio-language");
  const browser = navigator.language?.slice(0, 2).toLowerCase();
  return [fromUrl, stored, browser].find((lang) => supportedLanguages.includes(lang)) || defaultLanguage;
}

export async function setLanguage(language) {
  const lang = supportedLanguages.includes(language) ? language : defaultLanguage;
  const response = await fetch(`assets/i18n/${lang}.json`);
  if (!response.ok) throw new Error(`Translation file unavailable: ${lang}`);
  const dictionary = await response.json();

  document.documentElement.lang = lang;
  document.title = dictionary.meta.title;
  document.querySelector('meta[name="description"]')?.setAttribute("content", dictionary.meta.description);

  document.querySelectorAll("[data-i18n]").forEach((element) => {
    const value = getValue(dictionary, element.dataset.i18n);
    if (value) element.textContent = value;
  });
  document.querySelectorAll("[data-i18n-alt]").forEach((element) => {
    const value = getValue(dictionary, element.dataset.i18nAlt);
    if (value) element.alt = value;
  });
  document.querySelectorAll("[data-i18n-aria-label]").forEach((element) => {
    const value = getValue(dictionary, element.dataset.i18nAriaLabel);
    if (value) element.setAttribute("aria-label", value);
  });
  document.querySelectorAll("[data-cv-link]").forEach((link) => {
    link.href = `assets/documents/cv-giulia-cardarilli-${lang}.pdf`;
  });

  document.querySelector("#language-select").value = lang;
  localStorage.setItem("giulia-portfolio-language", lang);
  window.history.replaceState({}, "", `${window.location.pathname}?lang=${lang}${window.location.hash}`);
}

export function initI18n() {
  const selector = document.querySelector("#language-select");
  selector.addEventListener("change", (event) => setLanguage(event.target.value));
  return setLanguage(getInitialLanguage());
}
EOF

cat > js/main.js <<'EOF'
import { initI18n } from "./i18n.js";

document.addEventListener("DOMContentLoaded", async () => {
  document.querySelector("#current-year").textContent = new Date().getFullYear();
  try {
    await initI18n();
  } catch (error) {
    console.error("Could not initialise translations.", error);
  }
});
EOF

printf '\nBase files created successfully.\n'
