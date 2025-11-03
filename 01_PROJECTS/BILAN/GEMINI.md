# GEMINI.md - BILAN Project

This document provides a comprehensive overview of the BILAN project directory. The purpose of this file is to serve as a starting point for any developer or team member to understand the project's structure, key components, and how to interact with them.

## Directory Overview

This directory contains business, marketing, and research materials for **BILAN**, a brand of electrolyte powder mixes. The project is focused on health, wellness, and establishing a strong market presence.

The directory is organized into the following key areas:

*   **Product Information:** Documents detailing the science behind the products, including `whatareElectrolytes.md`, `naturalFlavors.md`, and information on competitors' products in the `LMNT/` directory.
*   **Marketing & Sales:** A comprehensive collection of marketing strategies, sales playbooks, and campaign materials located in the `marketing/` and `SALES/` directories. This includes everything from high-level strategy (`bilanMarketingDosier.json`) to specific sales scripts (`marketing/yoga/yogaSalesScript.md`).
*   **Competitive Analysis:** The `competitiveAnalysis/` directory contains information about BILAN's main competitors, with a significant amount of research material on `LMNT`.
*   **RAG Application:** The `RAG/` directory contains a small Python-based web server and data files (`faq.json`, `electrolytes.md`) for a Retrieval-Augmented Generation (RAG) system. This is likely used to answer customer questions or generate content.

## Key Files

Here is a list of the most important files in this directory and their purpose:

*   `readme.md`: The main README for the project, providing a general overview of the file structure.
*   `bilanMarketingDosier.json`: A detailed marketing plan for BILAN, including target audience, market positioning, and budget.
*   `pricingBilan.md`: A document outlining the pricing strategy for BILAN's products.
*   `slogans.md`: A list of marketing slogans for the BILAN brand.
*   `RAG/server.py`: A simple Python web server for the RAG application.
*   `RAG/faq.json`: A set of frequently asked questions and answers about hydration and electrolytes, used by the RAG application.
*   `competitiveAnalysis/Readme.md`: An overview of the competitive landscape.
*   `SALES/1_Introduction_Sales_Playbook.md`: The starting point for the company's sales strategy.

## Usage

This directory is intended to be a central repository for all information related to the BILAN brand. It is used for:

*   **Onboarding:** New team members can use this directory to get up to speed on the product, marketing, and sales strategies.
*   **Content Generation:** The `RAG/` directory and the various `.md` files can be used as a source of truth for generating marketing copy, social media posts, and customer support responses.
*   **Strategic Planning:** The documents in this directory can be used to inform strategic decisions about product development, marketing, and sales.

## RAG Application

The `RAG/` directory contains a simple Python web server that can be used to serve the contents of the directory over HTTP. This is likely used to power a RAG (Retrieval-Augmented Generation) model for question answering.

To run the server, navigate to the `RAG/` directory and run the following command:

```bash
python server.py
```

The server will start on `http://localhost:8000`.
