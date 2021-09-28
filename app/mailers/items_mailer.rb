class ItemsMailer < ApplicationMailer
  default from: 'info@mystore.localhost',
          template_path: 'mailers/items'

  def item_destroyed(item)
    @item = item
    mail to: 'example@mail.com',
         subject: 'Item destroyed'
  end
end
