# app/admin/events.rb
ActiveAdmin.register Event do
  permit_params :title, :description, :date # Ajoutez les attributs nécessaires

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :date
    actions
  end

  filter :title
  filter :date

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :date
    end
    f.actions
  end
end
