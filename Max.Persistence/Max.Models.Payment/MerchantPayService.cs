/*
 * 本文件由根据实体插件自动生成，请勿更改
 * =========================== */

using System;
using Max.Framework.MVC;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Max.Models.Payment
{
    public class MerchantPayService 
    {

        [Required]
        [CharacterLength(50)]
        [Display(Name="PayChannelId")]
        public string PayChannelId{ get; set; }

        /// <summary>
        /// 主键ID
        /// </summary>
        [Key]
        [Required]
        [CharacterLength(50)]
        [Display(Name="主键ID")]
        public string MerchantPayServiceId{ get; set; }

        /// <summary>
        /// 商户ID
        /// </summary>
        [Required]
        [CharacterLength(50)]
        [Display(Name="商户ID")]
        public string MerchantId{ get; set; }

        /// <summary>
        /// 产品ID
        /// </summary>
        [Required]
        [CharacterLength(50)]
        [Display(Name="产品ID")]
        public string ServiceId{ get; set; }

        /// <summary>
        /// 商户手续费率
        /// </summary>
        [Required]
        [Display(Name="商户手续费率")]
        public decimal MerchantFeeRate{ get; set; }

        /// <summary>
        /// 代理手续费率
        /// </summary>
        [Required]
        [Display(Name="代理手续费率")]
        public decimal AgentFeeRate{ get; set; }

        /// <summary>
        /// 商户状态
        /// </summary>
        [Required]
        [Display(Name="商户状态")]
        public int Status{ get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [CharacterLength(500)]
        [Display(Name="备注")]
        public string Remark{ get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        [Required]
        [Display(Name="创建时间")]
        public DateTime CreateTime{ get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        [Required]
        [CharacterLength(50)]
        [Display(Name="创建人")]
        public string CreateBy{ get; set; }

        /// <summary>
        /// 更新时间
        /// </summary>
        [Display(Name="更新时间")]
        public DateTime? UpdateTime{ get; set; }

        /// <summary>
        /// 更新人
        /// </summary>
        [CharacterLength(50)]
        [Display(Name="更新人")]
        public string UpdateBy{ get; set; }

        /// <summary>
        /// 是否删除
        /// </summary>
        [Required]
        [Display(Name="是否删除")]
        public int Isdelete{ get; set; }

        [Required]
        [Display(Name = "产品类型")]
        public int ServiceType { get; set; }

    }
}