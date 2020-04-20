# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:courses, ignore_index_errors: true) do
      primary_key :id
      String :name, size: 120, null: false
      Integer :lecture_id, null: false
      Integer :tutorial_id
      Integer :template_id

      index [:id], name: :teaching_units_id_uindex, unique: true
    end

    create_table(:forms, ignore_index_errors: true) do
      primary_key :id
      Integer :author_id, null: false
      Integer :target_id, null: false
      Integer :template_id
      TrueClass :anonymous, null: false
      Integer :created_at, null: false
      Integer :modified_at, null: false

      index [:id], name: :forms_id_uindex, unique: true
    end

    create_table(:messages, ignore_index_errors: true) do
      primary_key :id
      Integer :thread_id, null: false
      Integer :author_id, null: false
      String :content, text: true, null: false
      Integer :sent_at, null: false

      index [:id], name: :messages_id_uindex, unique: true
    end

    create_table(:questions, ignore_index_errors: true) do
      primary_key :id
      Integer :template_id, null: false
      Integer :type, null: false
      String :text, size: 255

      index [:id], name: :questions_id_uindex, unique: true
    end

    create_table(:roles, ignore_index_errors: true) do
      primary_key :id
      Integer :user_id, null: false
      String :role, size: 120, null: false

      index [:id], name: :roles_id_uindex, unique: true
    end

    create_table(:teaching_units, ignore_index_errors: true) do
      primary_key :id
      Integer :teacher_id, null: false
      Integer :weekday, null: false
      Integer :start_time, null: false
      Integer :end_time, null: false
      Integer :course_id, null: false
      String :group_filter, size: 120, null: false
      Integer :template_id, null: false

      index [:id], unique: true
    end

    create_table(:threads, ignore_index_errors: true) do
      primary_key :id
      Integer :form_id, null: false

      index [:id], name: :threads_id_uindex, unique: true
    end

    create_join_table(thread_id: :threads, user_id: :users)

    create_table(:users, ignore_index_errors: true) do
      primary_key :id
      String :email, size: 120, null: false
      String :name, size: 120, null: false
      String :group, size: 120

      index [:email], name: :table_name_email_uindex, unique: true
      index [:id], name: :table_name_id_uindex, unique: true
    end
  end
end
