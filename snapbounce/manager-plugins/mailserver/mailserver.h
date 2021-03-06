// Snap Websites Server -- manage the mailserver settings
// Copyright (c) 2016-2018  Made to Order Software Corp.  All Rights Reserved
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#pragma once

#include "snapmanager/manager.h"
#include "snapmanager/plugin_base.h"

#include <snapwebsites/plugins.h>

#include <QDomDocument>

namespace snap
{
namespace mailserver
{


enum class name_t
{
    SNAP_NAME_SNAPMANAGERCGI_MAILSERVER_NAME
};
char const * get_name(name_t name) __attribute__ ((const));



class mailserver_exception : public snap_exception
{
public:
    mailserver_exception(char const *        what_msg) : snap_exception("mailserver", what_msg) {}
    mailserver_exception(std::string const & what_msg) : snap_exception("mailserver", what_msg) {}
    mailserver_exception(QString const &     what_msg) : snap_exception("mailserver", what_msg) {}
};

class mailserver_exception_invalid_argument : public mailserver_exception
{
public:
    mailserver_exception_invalid_argument(char const *        what_msg) : mailserver_exception(what_msg) {}
    mailserver_exception_invalid_argument(std::string const & what_msg) : mailserver_exception(what_msg) {}
    mailserver_exception_invalid_argument(QString const &     what_msg) : mailserver_exception(what_msg) {}
};





class mailserver
    : public snap_manager::plugin_base
{
public:
                            mailserver();
                            mailserver(mailserver const & rhs) = delete;
    virtual                 ~mailserver() override;

    mailserver &            operator = (mailserver const & rhs) = delete;

    static mailserver *     instance();

    // plugins::plugin implementation
    virtual QString         description() const override;
    virtual QString         dependencies() const override;
    virtual int64_t         do_update(int64_t last_updated) override;
    virtual void            bootstrap(snap_child * snap) override;

    // manager overload
    virtual bool            display_value(QDomElement parent, snap_manager::status_t const & s, snap::snap_uri const & uri) override;
    virtual bool            apply_setting(QString const & button_name, QString const & field_name, QString const & new_value, QString const & old_value, std::set<QString> & services) override;

    // server signal
    void                    on_retrieve_status(snap_manager::server_status & server_status);

private:
    bool                    is_installed() const;
    void                    retrieve_bundles_status(snap_manager::server_status & server_status);
    bool                    install_bundle(bool const install, QString const & bundle_name, std::set<QString> & services);

    snap_manager::manager * f_snap = nullptr;
};

} // namespace mailserver
} // namespace snap
// vim: ts=4 sw=4 et
