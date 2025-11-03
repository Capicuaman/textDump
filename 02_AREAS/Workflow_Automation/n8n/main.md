# Store the Output of a Workflow

In **n8n**, you can store the output of a workflow in various ways depending on your requirements. Here are some common methods:

---

### Store Output in a File

- Use the **"Write Binary File"** or **"Write File"** node to save the output to a file (e.g., JSON, CSV, or text file).
- Configure the node to specify the file path and format.

---

### Store Output in a Database

- Use a database node like **"PostgreSQL"**, **"MySQL"**, or **"MongoDB"** to insert the output into a table or collection.
- Map the output fields to the database columns.

---

### Store Output in Google Sheets or Airtable

- Use the **"Google Sheets"** or **"Airtable"** node to append or update records in a spreadsheet or table.
- Configure the node to map the output to the appropriate columns.

---

### Store Output in a Webhook or API

- Use the **"HTTP Request"** node to send the output to an external API or webhook.
- Configure the node with the endpoint URL and payload format.

---

### Store Output in Variables or Memory

- Use the **"Function"** node to manipulate and store the output in workflow variables.
- Example:

  ```javascript
  // Store output in a variable
  const output = $input.all();
  $node.setParameter('output', output);
  ```

---

### Store Output in Cloud Storage (S3, Google Drive, etc.)

- Use nodes like **"AWS S3"** or **"Google Drive"** to upload the output to cloud storage.
- Configure the node with the bucket/folder path and file details.

---

### Store Output in a Message Queue (RabbitMQ, etc.)

- Use nodes like **"RabbitMQ"** to publish the output to a queue for further processing.

---

### Store Output in Notion or Other Apps

- Use nodes like **"Notion"** to save the output as a page or database entry in Notion.

---

### Example Workflow

1. **Trigger Node** (e.g., Webhook, Schedule, or Manual Trigger).
2. **Action Node** (e.g., HTTP Request, Function, or Database Query).
3. **Storage Node** (e.g., Write File, Database, or Google Sheets).

---

Would you like a step-by-step guide for a specific storage method? Let me know your use case!

