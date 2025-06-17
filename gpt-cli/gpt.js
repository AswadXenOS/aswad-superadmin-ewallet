import OpenAI from 'openai';
import dotenv from 'dotenv';
dotenv.config();

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

const readline = await import('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

console.log("🤖 GPT CLI sudah siap. Tulis soalan...");

rl.on('line', async (input) => {
  try {
    const chat = await openai.chat.completions.create({
      messages: [{ role: 'user', content: input }],
      model: 'gpt-4o',
    });

    console.log("GPT:", chat.choices[0].message.content);
  } catch (err) {
    console.error("❌ Error:", err.message);
  }
});
