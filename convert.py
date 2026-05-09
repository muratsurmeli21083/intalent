import os
import re

directories = [
    "giri_yap_stitch",
    "profil_bilgilerini_doldur",
    "profil_ve_live_cv",
    "tercihlerini_belirle"
]

base_dir = "/Users/murat/Downloads/stitch_intalent_kariyer_platform"

def to_camel_case(snake_str):
    components = snake_str.split('_')
    return ''.join(x.title() for x in components)

def html_to_jsx(html):
    # Very basic html to jsx conversion
    html = html.replace('class=', 'className=')
    html = html.replace('for=', 'htmlFor=')
    html = html.replace('viewbox=', 'viewBox=')
    html = re.sub(r'<!--(.*?)-->', r'{/* \1 */}', html, flags=re.DOTALL)
    # self closing tags
    html = re.sub(r'<(img|input|hr|br|meta|link)([^>]*?)(?<!/)>', r'<\1\2 />', html)
    # remove <script> tags
    html = re.sub(r'<script.*?>.*?</script>', '', html, flags=re.DOTALL)
    return html

for d in directories:
    html_file = os.path.join(base_dir, d, "code.html")
    if not os.path.exists(html_file): continue
    
    with open(html_file, "r") as f:
        content = f.read()
    
    body_match = re.search(r'<body[^>]*>(.*?)</body>', content, re.DOTALL | re.IGNORECASE)
    if not body_match: continue
    
    body_content = body_match.group(1)
    body_content = html_to_jsx(body_content)
    
    component_name = to_camel_case(d)
    
    jsx = f"""import React from 'react';
import {{ motion }} from 'framer-motion';
import {{ useNavigate }} from 'react-router-dom';

export default function {component_name}() {{
  const navigate = useNavigate();
  return (
    <motion.div 
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.3 }}
      className="bg-surface font-body-md text-on-surface min-h-screen flex flex-col items-center justify-center overflow-x-hidden w-full relative"
    >
        {body_content}
    </motion.div>
  );
}}
"""
    output_path = os.path.join(base_dir, "app", "src", f"{component_name}.jsx")
    with open(output_path, "w") as f:
        f.write(jsx)

print("Done")
