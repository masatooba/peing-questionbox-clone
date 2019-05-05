module ApplicationHelper
  def default_meta_tags
   {
     site: ENV["APP_NAME"],
     title: ENV["APP_NAME_EN"],
     reverse: true,
     charset: 'utf-8',
     description: ENV["DESCRIPTION"],
     keywords: ENV["KEYWORDS"],
     canonical: request.original_url,
     separator: '|',
     icon: [
       { href: image_url('favicon.ico') },
       { href: image_url('box.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
     ],
     og: {
       site_name: ENV["APP_NAME"], # もしくは site_name: :site
       title: ENV["APP_NAME_EN"], # もしくは title: :title
       description: ENV["DESCRIPTION"], # もしくは description: :description
       type: 'website',
       url: request.original_url,
       image: image_url('main_image.png'),
       locale: 'ja_JP',
     },
     twitter: {
       card: 'summary_large_image',
       site: '@_SeiyaTakahashi',
     }
   }
   # 変更するべきあたいはtitle, description, og:title, og;description, og:image, 
 end
end
