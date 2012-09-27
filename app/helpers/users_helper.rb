module UsersHelper
  def role_tag(user,site)
    if site.site_admins.exists?(user)
      t('activerecord.attributes.user.admin')
    else
      t('activerecord.attributes.user.normal')
    end
  end
end
