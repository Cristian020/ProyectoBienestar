import { IonicModule } from '@ionic/angular';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { BeneficiarioTabsPageRoutingModule } from './beneficiario-routing.module';

import { BeneficiarioTabsPage } from './beneficiario.page';

@NgModule({
  imports: [
    IonicModule,
    CommonModule,
    FormsModule,
    BeneficiarioTabsPageRoutingModule
  ],
  declarations: [BeneficiarioTabsPage]
})
export class BeneficiarioTabsPageModule {}
