defmodule FaviconFetcher do
  @user_agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9"
  @icon_css_paths ["link[rel='icon']",
	                 "link[rel='shortcut icon']"]

  @moduledoc """
    The main module for scraping websites and extracting favicons.
  """

  @doc """
    Get the favicon URL using FaviconFetcher.favicon(website_url)
  """

  # The longest link is probably the icon with the largest size, so take that.
  # If no icon could be found in the HTML code, try direct link.
  def favicon(website_url) do
    ensure_scheme(website_url)
    |> favicons
    |> Enum.sort_by(&String.length/1)
    |> Enum.reverse
    |> Enum.at(0) || try_direct_link(website_url)
  end

  def favicons(website_url) do
    html_body(website_url)
    |> extract_favicon_links
    |> Enum.map(&(Link.expand(&1, website_url)))
  end

  def extract_favicon_links(body) do
    Enum.flat_map(@icon_css_paths, fn css_path ->
      Floki.find(body, css_path)
      |> Floki.attribute("href")
    end)
    |> Enum.reject(&(&1 == [])) # Remove empty lists
  end

  def ensure_scheme(website_url) do
    if String.starts_with?(website_url, "http") do
      website_url
    else
      "http://" <> website_url
    end
  end

  def try_direct_link(website_url) do
    direct_favicon_link =
      ensure_scheme(website_url) <> "/favicon.ico"

    response =
      HTTPoison.get!(direct_favicon_link, [{"User-Agent", @user_agent}], [hackney: [{:follow_redirect, true}], ssl: [versions: [:"tlsv1.2"]]])

    # Is it an image?
    if is_binary(response.body) do
      direct_favicon_link
    end
  end

  def html_body(url) do
    HTTPoison.get!(url, [{"User-Agent", @user_agent}], [hackney: [{:follow_redirect, true}], ssl: [versions: [:"tlsv1.2"]]]).body
    |> String.downcase
  end
end
