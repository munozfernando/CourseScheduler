//IsolateBit() and Permissions enum created by Jon Holmes

/* Model for RolePermissions
 * RolePermissions: the permission set of a particular object for roles
 * Created on 2/27/19 Jason Durfee
 */

using Microsoft.AspNetCore.Mvc;
using System;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models {
    public class RolePermission : DatabaseObject {
        public RolePermission(int value) {
            CanDelete = IsolateBit(value, Permissions.Delete);
            CanAdd = IsolateBit(value, Permissions.Add);
            CanView = IsolateBit(value, Permissions.View);
            CanEdit = IsolateBit(value, Permissions.Edit);
        }

        public int GetIntValue() {
            int retVal = 0;
            if (CanDelete) {
                retVal += 8;
            }
            if (CanAdd) {
                retVal += 4;
            }
            if (CanView) {
                retVal += 2;
            }
            if (CanEdit) {
                retVal += 1;
            }
            return retVal;
        }

        public RolePermission() {

        }

        private bool _CanDelete;
        private bool _CanAdd;
        private bool _CanView;
        private bool _CanEdit;


        [UIHint("Checkbox")]
        [Display(Name = "Can Delete")]
        public bool CanDelete {
            get { return _CanDelete; }
            set { _CanDelete = value; }
        }


        [UIHint("Checkbox")]
        [Display(Name = "Can Add")]
        public bool CanAdd {
            get { return _CanAdd; }
            set { _CanAdd = value; }
        }

        [UIHint("Checkbox")]
        [Display(Name = "Can View")]
        public bool CanView {
            get { return _CanView; }
            set { _CanView = value; }
        }

        [UIHint("Checkbox")]
        [Display(Name = "Can Edit")]
        public bool CanEdit {
            get { return _CanEdit; }
            set { _CanEdit = value; }
        }

        public bool IsolateBit(int value, Permissions pm) {
            return (value / (int)pm) % 2 == 1;
        }

        public enum Permissions {
            Edit = 1, View = 2, Add = 4, Delete = 8
        }

        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {

        }
    }
}
