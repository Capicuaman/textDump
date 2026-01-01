# BILAN Random Theme Selector - n8n Fixed Code

## Corrected n8n Function Code (No 'json' property error)
Copy this directly into your n8n Function node:

```javascript
// BILAN Random Theme Selector Function
const bilanThemeSelector = {
  // Educational content themes
  educational: [
    {
      theme: "What Are Electrolytes?",
      focus: "Basic electrolyte education",
      keywords: ["electrolytes", "hydration", "minerals", "body function"],
      content_angle: "Educational foundation post",
      call_to_action: "Learn more about electrolyte balance"
    },
    {
      theme: "The Role of Electrolytes in Hydration",
      focus: "Hydration science",
      keywords: ["hydration", "water balance", "fluid retention", "cellular hydration"],
      content_angle: "Science-based explanation",
      call_to_action: "Discover optimal hydration strategies"
    },
    {
      theme: "Electrolytes for Performance and Recovery",
      focus: "Athletic performance",
      keywords: ["performance", "recovery", "athletics", "endurance", "muscle function"],
      content_angle: "Athletic performance focus",
      call_to_action: "Elevate your performance with proper electrolytes"
    },
    {
      theme: "Sodium: The Misunderstood Electrolyte",
      focus: "Sodium education",
      keywords: ["sodium", "salt", "blood pressure", "essential mineral"],
      content_angle: "Myth-busting content",
      call_to_action: "Understand sodium's role in health"
    },
    {
      theme: "Potassium: The Heart Mineral",
      focus: "Potassium benefits",
      keywords: ["potassium", "heart health", "muscle cramps", "nervous system"],
      content_angle: "Heart health emphasis",
      call_to_action: "Support your heart with potassium"
    },
    {
      theme: "Magnesium: The Relaxation Mineral",
      focus: "Magnesium benefits",
      keywords: ["magnesium", "relaxation", "sleep", "muscle recovery", "stress"],
      content_angle: "Wellness and recovery focus",
      call_to_action: "Find calm with proper magnesium"
    }
  ],

  // Brand pillar themes
  brand_pillars: [
    {
      theme: "Euhidratación y Equilibrio",
      focus: "Superior hydration concept",
      keywords: ["euhidratación", "balance", "optimal hydration", "electrolyte balance"],
      content_angle: "Premium positioning",
      call_to_action: "Experience superior hydration with BILAN"
    },
    {
      theme: "La Batería Humana",
      focus: "Body as battery analogy",
      keywords: ["batería", "energy", "cellular energy", "power", "vitality"],
      content_angle: "Energy and power metaphor",
      call_to_action: "Power your human battery with BILAN"
    },
    {
      theme: "Pureza y Calidad Científica",
      focus: "Scientific purity",
      keywords: ["pureza", "calidad", "científico", "libre de aditivos", "evidencia"],
      content_angle: "Scientific credibility",
      call_to_action: "Trust the science behind BILAN"
    },
    {
      theme: "La Alternativa Pura",
      focus: "Clean alternative to sugary drinks",
      keywords: ["alternativa", "sin azúcar", "limpio", "natural", "saludable"],
      content_angle: "Clean comparison",
      call_to_action: "Choose the pure alternative - BILAN"
    }
  ],

  // Seasonal content themes
  seasonal: [
    {
      theme: "Summer Hydration Essentials",
      focus: "Hot weather hydration",
      keywords: ["verano", "calor", "deshidratación", "clima cálido", "sol"],
      content_angle: "Seasonal relevance",
      call_to_action: "Stay hydrated all summer with BILAN"
    },
    {
      theme: "Winter Indoor Hydration",
      focus: "Cold weather hydration",
      keywords: ["invierno", "calefacción", "clima seco", "interior", "humedad"],
      content_angle: "Year-round necessity",
      call_to_action: "Don't forget winter hydration with BILAN"
    },
    {
      theme: "Holiday Health & Hydration",
      focus: "Seasonal wellness",
      keywords: ["fiestas", "salud", "celebración", "equilibrio", "moderación"],
      content_angle: "Holiday wellness",
      call_to_action: "Maintain balance during holidays with BILAN"
    }
  ],

  // Product-focused themes
  product_focus: [
    {
      theme: "BILAN vs Sports Drinks",
      focus: "Product comparison",
      keywords: ["comparación", "bebidas deportivas", "azúcar", "aditivos", "limpio"],
      content_angle: "Competitive differentiation",
      call_to_action: "See why BILAN beats sports drinks"
    },
    {
      theme: "The Science Behind BILAN",
      focus: "Product formulation",
      keywords: ["ciencia", "formulación", "ingredientes", "investigación", "eficacia"],
      content_angle: "Scientific validation",
      call_to_action: "Discover the science in every BILAN serving"
    },
    {
      theme: "How to Use BILAN Daily",
      focus: "Usage instructions",
      keywords: ["cómo usar", "dosificación", "diario", "rutina", "mejor momento"],
      content_angle: "Practical guidance",
      call_to_action: "Optimize your daily routine with BILAN"
    }
  ],

  // Health and wellness themes
  health_wellness: [
    {
      theme: "Electrolytes and Mental Focus",
      focus: "Cognitive benefits",
      keywords: ["concentración", "enfoque", "cerebro", "función cognitiva", "claridad mental"],
      content_angle: "Mental performance",
      call_to_action: "Sharpen your focus with BILAN"
    },
    {
      theme: "Hydration for Skin Health",
      focus: "Beauty benefits",
      keywords: ["piel", "belleza", "hidratación", "salud cutánea", "anti-envejecimiento"],
      content_angle: "Beauty and wellness",
      call_to_action: "Nourish your skin from within with BILAN"
    },
    {
      theme: "Electrolytes for Better Sleep",
      focus: "Sleep quality",
      keywords: ["sueño", "descanso", "calidad del sueño", "recuperación nocturna", "relajación"],
      content_angle: "Sleep optimization",
      call_to_action: "Enhance your sleep with BILAN"
    }
  ],

  // Lifestyle themes
  lifestyle: [
    {
      theme: "Office Hydration Habits",
      focus: "Workplace wellness",
      keywords: ["oficina", "trabajo", "productividad", "enfoque laboral", "rutina diaria"],
      content_angle: "Professional productivity",
      call_to_action: "Boost workplace performance with BILAN"
    },
    {
      theme: "Travel Hydration Tips",
      focus: "Travel wellness",
      keywords: ["viaje", "avión", "deshidratación", "jet lag", "energía"],
      content_angle: "Travel preparation",
      call_to_action: "Travel smarter with BILAN hydration"
    },
    {
      theme: "Weekend Warrior Recovery",
      focus: "Recreational athletics",
      keywords: ["fin de semana", "guerrero", "recuperación", "actividad", "energía"],
      content_angle: "Weekend activity support",
      call_to_action: "Conquer your weekends with BILAN"
    }
  ]
};

// Random selection function
function selectRandomTheme() {
  // Category weights
  const categoryWeights = {
    educational: 30,
    brand_pillars: 20,
    seasonal: 15,
    product_focus: 15,
    health_wellness: 15,
    lifestyle: 5
  };

  // Calculate weighted random selection
  const totalWeight = Object.values(categoryWeights).reduce((a, b) => a + b, 0);
  let random = Math.random() * totalWeight;
  
  let selectedCategory = null;
  for (const [category, weight] of Object.entries(categoryWeights)) {
    random -= weight;
    if (random <= 0) {
      selectedCategory = category;
      break;
    }
  }

  // Fallback to random category if weighted selection fails
  if (!selectedCategory) {
    const categories = Object.keys(bilanThemeSelector);
    selectedCategory = categories[Math.floor(Math.random() * categories.length)];
  }

  // Select random theme from chosen category
  const themesInCategory = bilanThemeSelector[selectedCategory];
  const selectedTheme = themesInCategory[Math.floor(Math.random() * themesInCategory.length)];
  
  // Generate metadata
  const timestamp = new Date().toISOString();
  const contentId = `bilan_${Date.now()}`;
  
  return {
    ...selectedTheme,
    category: selectedCategory,
    content_id: contentId,
    selected_at: timestamp,
    prompt_context: `Create social media content about: ${selectedTheme.theme}. Focus: ${selectedTheme.focus}. Content angle: ${selectedTheme.content_angle}. Call to action: ${selectedTheme.call_to_action}. Include keywords: ${selectedTheme.keywords.join(', ')}. Category: ${selectedCategory}.`
  };
}

// Execute selection and return directly (not in an array)
const selectedTheme = selectRandomTheme();

// Return object directly - not wrapped in array
return {
  json: {
    theme: selectedTheme.theme,
    focus: selectedTheme.focus,
    keywords: selectedTheme.keywords,
    category: selectedTheme.category,
    content_angle: selectedTheme.content_angle,
    call_to_action: selectedTheme.call_to_action,
    content_id: selectedTheme.content_id,
    selected_at: selectedTheme.selected_at,
    prompt_context: selectedTheme.prompt_context
  }
};
```

## Simple Version (if you want fewer themes)
```javascript
// Simple BILAN Theme Selector
const themes = [
  "What Are Electrolytes?",
  "The Role of Electrolytes in Hydration", 
  "Electrolytes for Performance and Recovery",
  "Euhidratación y Equilibrio",
  "La Batería Humana",
  "Pureza y Calidad Científica",
  "La Alternativa Pura",
  "Summer Hydration Essentials",
  "BILAN vs Sports Drinks",
  "The Science Behind BILAN"
];

const randomTheme = themes[Math.floor(Math.random() * themes.length)];

// Return object directly
return {
  json: {
    theme: randomTheme,
    content_id: `bilan_${Date.now()}`,
    selected_at: new Date().toISOString(),
    prompt_context: `Create social media content about: ${randomTheme}`
  }
};
```

## Key Fixes Made:
1. **Removed array wrapper** - Changed `return [{json: {...}}]` to `return {json: {...}}`
2. **Direct object return** - n8n Function nodes expect a single object, not an array
3. **Cleaner structure** - No nested complications

## Expected Output:
```json
{
  "theme": "What Are Electrolytes?",
  "focus": "Basic electrolyte education",
  "keywords": ["electrolytes", "hydration", "minerals", "body function"],
  "category": "educational",
  "content_angle": "Educational foundation post",
  "call_to_action: "Learn more about electrolyte balance",
  "content_id": "bilan_1642234567890",
  "selected_at": "2025-01-15T09:00:00Z",
  "prompt_context": "Create social media content about: What Are Electrolytes?. Focus: Basic electrolyte education. Content angle: Educational foundation post. Call to action: Learn more about electrolyte balance. Include keywords: electrolytes, hydration, minerals, body function. Category: educational."
}
```

The 'json' property error should now be resolved!