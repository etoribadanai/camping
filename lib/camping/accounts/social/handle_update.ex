defmodule Camping.Accounts.Social.HandleUpdate do
  alias Camping.Accounts

  def update(user, attrs) do
    execute_update(user, attrs)
  end

  defp execute_update(user, attrs) do
    Accounts.update_social_login(user, attrs)
  end
end
