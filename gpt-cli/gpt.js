const readline = require('readline');
const { Configuration, OpenAIApi } = require('openai');
require('dotenv').config({ path: '../.env' });

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
const openai = new OpenAIApi(new Configuration({ apiKey: process.env.OPENAI_API_KEY }));

(async () => {
  while (true) {
    rl.question("🤖 Prompt: ", async (q) => {
      const res = await openai.createChatCompletion({
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: q }],
      });
      console.log("💬", res.data.choices[0].message.content);
    });
  }
})();
