# punkland-chat-gpt-demo
펑크랜드 [OpenApi](https://openai.com/product) 사용 예제
# 사용법

```lua
local send_request = require("send_request")
```

```lua
-- 함수 호출 예시
local function chat_to_mina(message)
    local me = Client.myPlayerUnit
    local mina = Client.field.FindNearUnit(me.x, me.y, 200, 1, me)

    send_request_module.send_request_to_openai(message, function(response)
        if mina then
            print("Robot: " .. response)
            mina.Say(response)
        end
    end)
end

-- 채팅이 일어날때마다 chat_to_mina 함수 호출
Client.onChat.Add(function(chat)
    chat_to_mina(chat.text)
end)
```
