class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.deliver
      flash[:success] = "Muito obrigado pelo seu contato!"
    else
      flash[:error] = "Preencha os campos corretamente."
    end

    redirect_to :back
  end

private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :subject, :message, :destination)
  end
end
