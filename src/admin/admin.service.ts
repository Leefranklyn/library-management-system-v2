/* eslint-disable prettier/prettier */
import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { DatabaseService } from 'src/database/database.service';
import { CloudinaryService } from 'src/cloudinary/cloudinary.service';
@Injectable()
export class AdminService {
  constructor(private readonly databaseService: DatabaseService,
    private readonly cloudinaryService: CloudinaryService) {}

  async createAdmin(createAdmin: Prisma.AdminCreateInput, profilePhoto: Express.Multer.File) {
    try {
      let profilePhotoUrl;
      if(profilePhoto) {
         profilePhotoUrl = await this.cloudinaryService.uploadFile(profilePhoto)
      }
      const newAdmin = await this.databaseService.admin.create({
        data: {
          ...createAdmin,
          profilePhoto: profilePhotoUrl.secure_url5 ,
        }
      })
      if(newAdmin) {
        return { status: 200, message: "Admin Registered", Admin: newAdmin}
      }
    } catch (error) {
      console.log(error)
      throw new Error("Error Occured When registering Admin")
    }
  }

  async findAllAdmins() {
    try {
      const Admins = await this.databaseService.admin.findMany();
      if(!Admins) {
        throw new NotFoundException("Admins Not Found")
      }
      return {status: 200, Admins: Admins}
    } catch (error:any) {
      console.log(error)
      throw new error("Error Getting Admins")
    }
  }

  async findOneAdmin(id: number) {
    return `This action returns a #${id} admin`;
  }

  async updateAdmin(id: string, updateAdmin: Prisma.AdminUpdateInput, profilePhoto: Express.Multer.File) {
    try {
      let profilePhotoUrl;
      if(profilePhoto) {
        profilePhotoUrl = await this.cloudinaryService.uploadFile(profilePhoto)
      };

      const updatedAdmin = await this.databaseService.admin.update({
        where: {
          id: id
        },
        data: {
          ...updateAdmin,
          profilePhoto: profilePhotoUrl.secure_url
        }
      });
      if(!updatedAdmin) {

      }
    } catch (error) {
      console.log(error);
      throw new error("Failed in Updating Admin");
    };
  };

  async deleteAdmin(id: number) {
    return `This action removes a #${id} admin`;
  }
}
