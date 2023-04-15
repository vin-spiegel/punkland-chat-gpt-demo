---@ 여기에 openai api에서 발급받은 api 키를 넣어주세요
---@ 본인이 발급받은 키를 넣어야합니다. 해당 키는 작동하지 않습니다.
---@ 키발급 링크: https://openai.com/product
local api_key = "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"

local OpenAI = {
    api_key = api_key,
    Completion = {
        url = "https://api.openai.com/v1/completions"
    },
    ChatCompletion = {
        url = "https://api.openai.com/v1/chat/completions"
    },
}

OpenAI.headers = {
    ["Content-Type"] = "application/json",
    Authorization = "Bearer " .. api_key,
}

local function get_body_completion(data)
    return {
        model = data.model,
        prompt = data.prompt,
        temperature = data.temperature,
        max_tokens = data.max_tokens,
        top_p = data.top_p,
        n = data.n,
        frequency_penalty = data.frequency_penalty,
        presence_penalty = data.presence_penalty,
        stop = data.stop
    }
end

local function get_body_chat_completion(data)
    return {
        model = data.model,
        messages = data.messages,
        temperature = data.temperature,
        max_tokens = data.max_tokens,
        top_p = data.top_p,
        n = data.n,
        frequency_penalty = data.frequency_penalty,
        presence_penalty = data.presence_penalty,
        stop = data.stop
    }
end

local function resolve_indent(text)
    return string.gsub(text, "\n", "")
end

function OpenAI.Completion.create(data, func)
    local function callback(response)
        local result = json.parse(response)
        
        if result.error ~= nil then
            print("error: " .. result.error.type .. " " .. result.error.message)
        end
        
        func(resolve_indent(result.choices[1].text))
    end

    -- HttpPost 메소드 호출
    Client.HttpPost(OpenAI.Completion.url, get_body_completion(data), OpenAI.headers, callback)
end

return OpenAI