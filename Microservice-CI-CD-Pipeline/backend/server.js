const express = require("express");
const cors = require("cors");
const app = express();
const PORT = 3000;

// Enable CORS
app.use(cors());

app.get("/data", (req, res) => {
  res.json({
    message:
      "Hello from the Backend! I am Vaibhav Umbarkar",
  });
});

app.listen(PORT, () => {
  console.log(`Backend is running at http://localhost:${PORT}`);
  console.log("Success");
});
