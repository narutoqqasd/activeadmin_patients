ActiveAdmin.register Location do
	menu :priority => 3, label: proc{ t("active_admin.locations")}

	permit_params :code, :name
	config.filters = false

	index do
		column(t("active_admin.location.code")){ |location| location.code }
		column(t("active_admin.location.name")){ |location| location.name }
		actions
	end

	show do
		panel t('active_admin.details') do
			attributes_table_for resource do
				row :id
				row(t("active_admin.location.code")){ |location| location.code }
				row(t("active_admin.location.name")){ |location| location.name }
				row(t("active_admin.created_at")){ |location| location.created_at.strftime('%Y-%m-%d %H:%M') }
				row(t("active_admin.updated_at")){ |location| location.updated_at.strftime('%Y-%m-%d %H:%M') }
			end
		end
	end

	form do |f|
		f.inputs do
			f.input :code, label: t("active_admin.location.code")
			f.input :name, label: t("active_admin.location.name")
		end
		f.actions
	end

	action_item :show_back, only: :show do
  	link_to t('active_admin.back', model: active_admin_config.resource_label), admin_locations_path
  end


end
