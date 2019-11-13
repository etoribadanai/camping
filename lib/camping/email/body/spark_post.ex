defmodule Camping.Email.Body.SparkPost do
  @moduledoc """
  Module focused in format spark post body
  """
  def format(customer_name, email, template_id, substitution_data, tags) do
    %{
      options: %{
        click_tracking: true,
        transactional: true
      },
      content: %{
        template_id: template_id
      },
      substitution_data: substitution_data,
      recipients: [
        %{
          address: %{
            email: email,
            name: customer_name
          },
          tags: tags
        }
      ]
    }
  end
end
