module Backstage
  module Admin
    class ContactsController < Backstage::Admin::ApplicationController
      before_action :set_contacts, only: [:index, :show, :destroy]

      def index
        filter_contacts
      end

      def show
        @contact = @contacts.find(params[:id])
        @contact.mark_as_read!

        filter_contacts

        render :index
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

      def filter_contacts
        if params[:filter] == "read"
          @contacts = @contacts.read
        else
          @contacts = @contacts.unread
        end

        @contacts = @contacts.page(params[:page]).per(10).order("id desc")
      end
    end
  end
end
