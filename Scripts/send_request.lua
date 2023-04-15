local open_ai = require("open_ai")

--- 프롬프트를 조작해서 나만의 ai를 만들어보세요
---@param prompt string ai에게 제공할 대화내용.
---@param func fun(string) ai의 응답을 제어 할 함수
local function send_request_to_openai(prompt, func)
    open_ai.Completion.create({
        model = "text-davinci-003",
        prompt = prompt,
        temperature = 0.8,
        max_tokens = 400,
        top_p = 1,
        frequency_penalty = 0,
        presence_penalty = 0.6,
    }, func)
end

return {
    send_request_to_openai = send_request_to_openai
}