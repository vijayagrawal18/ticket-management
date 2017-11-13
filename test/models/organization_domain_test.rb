require 'test_helper'

class OrganizationDomainTest < ActiveSupport::TestCase
  test "having_all scope with one domain" do
    domain_ids = [domains(:d2).id]
    assert_equal 2, OrganizationDomain.having_all(domain_ids).pluck(:organization_id).count
  end

  test "having_all scope with multiple domains" do
    organization_ids = OrganizationDomain.having_all(domain_ids).pluck :organization_id
    assert_equal 1, organization_ids.count
    assert_equal organizations(:one).id, organization_ids.first
  end

  test "having_all scope with multiple domains is order agnostic" do
    organization_ids = OrganizationDomain.having_all(domain_ids.reverse).pluck :organization_id
    assert_equal 1, organization_ids.count
    assert_equal organizations(:one).id, organization_ids.first
  end

  private

  def domain_ids
    [domains(:d1).id, domains(:d2).id]
  end
end
