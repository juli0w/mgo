class AddPageables < ActiveRecord::Migration[5.0]
  def change
    Profile.find_each do |profile|
      if profile.pages.empty?
        contact_page = ContactPage.create(email: profile.company.try(:mail))
        profile.pages.create(title: "Contato", slug: "contact", index: 5,
                             description: "Deixe uma mensagem", pageable: contact_page)
      end
    end
  end
end
