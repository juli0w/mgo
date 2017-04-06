module Backstage
  class ContactsController < Backstage::ApplicationController
    before_action :set_company, only: [:index, :show, :destroy]
    before_action :set_contacts, only: [:index, :show]

    def index
    end

    def show
      @contact = @company.contacts.find(params[:id])
      @contact.mark_as_read!
    end

    def destroy
      @contact = @company.contacts.find(params[:id])
      @contact.delete

      flash[:success] = "Removido com sucesso!"
      redirect_to backstage_company_contacts_path(@company, filter: params[:filter])
    end

  private

    def set_contacts
      if params[:filter] == "read"
        contacts = @company.contacts.read
      else
        contacts = @company.contacts.unread
      end

      @contacts = contacts.page(params[:page]).per(6).order("id desc")
    end

    def set_company
      @company = current_user.companies.find(params[:company_id])
    end
  end
end
