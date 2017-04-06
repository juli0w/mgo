module Backstage
  module Admin
    class ContactsController < Backstage::Admin::ApplicationController
      before_action :set_contacts, only: [:index, :show, :destroy]

      def index
        @contacts = @contacts.search(params[:key]).page(params[:page]).per(10).order("id desc")
      end

      def show
        @contact = @contacts.find(params[:id])
        @contact.mark_as_read!
      end

      def destroy
        @contact = @contacts.find(params[:id])
        @contact.delete

        flash[:success] = "Removido com sucesso!"
        redirect_to backstage_admin_contacts_path
      end

    private

      def set_contacts
        @contacts = Contact.all
      end
    end
  end
end
