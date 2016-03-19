defmodule CoAP.Message do

  defstruct header: nil, options: [], payload: <<>>

  def sort_options(msg) do
    update_in(msg.options, &Enum.sort_by(&1, fn opt -> opt.number end))
  end

  def ack(msg) do
    {code_class, code_detail} = CoAP.response_code(:empty)
    %CoAP.Message{
      header: %CoAP.Header{
        version: CoAP.version,
        type: CoAP.type(:acknowledgement),
        code_class: code_class,
        code_detail: code_detail,
        message_id: msg.header.message_id,
        token: msg.header.token
      }
    }
  end

end
