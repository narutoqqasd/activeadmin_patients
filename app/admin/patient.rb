ActiveAdmin.register Patient do

	menu :priority => 2, label: proc{ t("active_admin.patients")}
	permit_params :first_name, :middle_name, :last_name, :birthday, :gender, :status, :location_id
	config.filters = false
	config.clear_action_items!

	scope proc{ I18n.t("active_admin.patient.published")}, :published, :default => true  do |scope|
		scope.where(is_deleted: false)
	end

	scope proc{ I18n.t("active_admin.patient.treatment") }, :treatment do |scope|
		scope.where(status: "treatment", is_deleted: false)
	end

	index do
		column(:id){ |patient| link_to("#{patient.id}", admin_patient_path(patient)) }
		column(t("active_admin.patient.full_name")){ |patient| patient.get_full_name }
		column(t("active_admin.patient.gender")){ |patient| patient.gender_text }
		column(t("active_admin.patient.status")){ |patient| patient.status }
		column(t("active_admin.patient.location_id")){ |patient| patient.location.name }
		column(t("active_admin.patient.viewed_count")){ |patient| patient.impressionist_count }
	end

	form do |f|
		f.inputs do
			f.input :first_name, label: t("active_admin.patient.first_name")
			f.input :middle_name, label: t("active_admin.patient.middle_name")
			f.input :last_name, label: t("active_admin.patient.last_name")
			f.input :gender, :as => :radio, label: t("active_admin.patient.gender")
			f.input :birthday, :as => :string, label: t("active_admin.patient.birthday"), input_html: {class: "jquery-datetimepicker"}
			f.input :status, label: t("active_admin.patient.status")
			f.input :location_id, :as => :select, :collection => Location.all.pluck(:name, :id), label: t("active_admin.patient.location_id")
		end
		f.actions
	end

	show do
		panel t('active_admin.details') do
			attributes_table_for resource do
				row(t("active_admin.patient.mr")){ |patient| patient.get_mr }
				row(t("active_admin.patient.full_name")){ |patient| patient.get_full_name }
				row(t("active_admin.patient.age")){ |patient| patient.get_age(patient.birthday)}
				row(t("active_admin.patient.gender")){ |patient| patient.gender_text }
				row(t("active_admin.patient.status")){ |patient| patient.status }
				row(t("active_admin.patient.location_id")){ |patient| link_to("#{patient.location.name}", admin_location_path(patient.location) )}
				row(t("active_admin.patient.viewed_count")){ |patient| patient.impressionist_count }
			end
		end
	end

	action_item :new, only: :index do
  	link_to t('active_admin.patient.new_patient', model: active_admin_config.resource_label), new_admin_patient_path
  end

	action_item :edit, only: :show  do
		link_to t('active_admin.edit', model: active_admin_config.resource_label), edit_admin_patient_path(resource)
	end

	action_item :show_back, only: :show do
  	link_to t('active_admin.back', model: active_admin_config.resource_label), admin_patients_path
  end

	member_action :is_deleted_patient, method: [:get] do
		resource.update(is_deleted: true)
		send(:redirect_to, admin_patients_path, :notice => "删除成功")
	end

	action_item :is_deleted, only: :show do
		link_to t('active_admin.patient.is_deleted', model: active_admin_config.resource_label), is_deleted_patient_admin_patient_path(resource)
	end

 controller do
 	 def show
		 @patient = Patient.find(params[:id])
		 impressionist(@patient)
	 end
 end



end
