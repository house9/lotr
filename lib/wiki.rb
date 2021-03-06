class Wiki < Precious::App
  set :gollum_path, CONFIG[:gollum][:repo_path]
  set :wiki_options, {
    base_path: CONFIG[:gollum][:base_path],
    live_preview: CONFIG[:gollum][:live_preview]
  }

  use Rack::Session::Cookie,
    key: CONFIG[:session][:key],
    secret: CONFIG[:session][:secret]

  before do
    if not session[:user]
      redirect '/'
    end
    Gollum::Wiki.default_committer_name = session[:user]['name']
    Gollum::Wiki.default_committer_email = session[:user]['email']
  end

  get '/' do
    show_page_or_file('Home')
  end
end

