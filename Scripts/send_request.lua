---@ 여기에 openai api에서 발급받은 api 키를 넣어주세요
---@ 본인이 발급받은 키를 넣어야합니다. 해당 키는 작동하지 않습니다.
---@ 키발급 링크: https://openai.com/product
local api_key = "sk-NbaqmrpAtfD0ss23237gAuXWaadsfFvT3BlbkFJmznoC2gmDQ1D323213IVSALBC"

--- 프롬프트를 조작해서 나만의 ai를 만들어보세요
---@param prompt string ai에게 제공할 대화내용.
---@param func fun(string) ai의 응답을 제어 할 함수
local function send_request_to_openai(prompt, func)
    local url = "https://api.openai.com/v1/completions"

    local headers = {
        ["Content-Type"] = "application/json",
        Authorization = "Bearer " .. api_key,
    }

    local body = {
        model = "text-davinci-003",
        prompt = prompt,
        temperature = 0.8,
        max_tokens = 400,
        top_p = 1,
        frequency_penalty = 0,
        presence_penalty = 0.6,
    }

    local function callback(response)
        local result = json.parse(response)
        local translated_text = result.choices[1].text
        
        translated_text = string.gsub(translated_text, "\n", "")

        func(translated_text)
    end

    -- HttpPost 메소드 호출
    Client.HttpPost(url, body, headers, callback)
end

return {
    send_request_to_openai = send_request_to_openai
}