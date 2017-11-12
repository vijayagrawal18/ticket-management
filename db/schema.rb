# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171111191532) do

  create_table "domains", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_domains_on_name", unique: true
  end

  create_table "organization_domains", force: :cascade do |t|
    t.integer "organization_id"
    t.integer "domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_organization_domains_on_domain_id"
    t.index ["organization_id"], name: "index_organization_domains_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.integer "_id", null: false
    t.string "url", null: false
    t.string "external_id", null: false
    t.string "name", null: false
    t.string "details"
    t.boolean "shared_tickets", default: false, null: false
    t.integer "tickets_count", default: 0, null: false
    t.integer "users_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["_id"], name: "index_organizations_on__id", unique: true
  end

  create_table "tag_lists", force: :cascade do |t|
    t.string "taggable_type"
    t.integer "taggable_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_tag_lists_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_tag_lists_on_taggable_type_and_taggable_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.string "_id", null: false
    t.string "url", null: false
    t.string "external_id", null: false
    t.integer "ticket_type"
    t.string "subject", null: false
    t.string "description"
    t.integer "priority"
    t.integer "status", default: 0, null: false
    t.integer "submitter_id", null: false
    t.integer "assignee_id"
    t.integer "organization_id"
    t.boolean "has_incidents", default: false, null: false
    t.datetime "due_at"
    t.integer "via", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["_id"], name: "index_tickets_on__id", unique: true
    t.index ["assignee_id"], name: "index_tickets_on_assignee_id"
    t.index ["organization_id"], name: "index_tickets_on_organization_id"
    t.index ["submitter_id"], name: "index_tickets_on_submitter_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "_id", null: false
    t.string "url", null: false
    t.string "external_id", null: false
    t.string "name", null: false
    t.string "alias"
    t.boolean "active", default: true, null: false
    t.boolean "verified", default: false, null: false
    t.boolean "shared", default: false, null: false
    t.string "locale"
    t.string "timezone"
    t.datetime "last_login_at", null: false
    t.string "email"
    t.string "phone"
    t.string "signature"
    t.integer "organization_id"
    t.boolean "suspended", default: false, null: false
    t.string "role", null: false
    t.integer "assigned_tickets_count", default: 0, null: false
    t.integer "submitted_tickets_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["_id"], name: "index_users_on__id", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

end
