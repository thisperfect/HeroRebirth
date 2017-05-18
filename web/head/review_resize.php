<?php
function my_image_resize($src_file, $dst_file , $new_width , $new_height) 
{
	if($new_width <1 || $new_height <1) 
	{
		echo "params width or height error !";
		exit();
	}
	if(!file_exists($src_file)) 
	{
		echo $src_file . " is not exists !";
		exit();
	}
	// ͼ������
	//$type = exif_imagetype($src_file);
	$type = IMAGETYPE_JPEG;
	$support_type=array(IMAGETYPE_JPEG , IMAGETYPE_PNG , IMAGETYPE_GIF);
	if(!in_array($type, $support_type,true)) 
	{
		echo "this type of image does not support! only support jpg , gif or png";
		exit();
	}
	//Load image
	switch($type) 
	{
		case IMAGETYPE_JPEG :
			$src_img=imagecreatefromjpeg($src_file);
			break;
		case IMAGETYPE_PNG :
			$src_img=imagecreatefrompng($src_file);
			break;
		case IMAGETYPE_GIF :
			$src_img=imagecreatefromgif($src_file);
			break;
		default:
			echo "Load image error!";
			exit();
	}
	$w=imagesx($src_img);
	$h=imagesy($src_img);
	$ratio_w=1.0 * $new_width / $w;
	$ratio_h=1.0 * $new_height / $h;
	$ratio=1.0;
	// ���ɵ�ͼ��ĸ߿��ԭ���Ķ�С���򶼴� ��ԭ���� ȡ������Ŵ�ȡ�������С����С�ı����ͱȽ�С�ˣ�
	if( ($ratio_w < 1 && $ratio_h < 1) || ($ratio_w > 1 && $ratio_h > 1)) 
	{
		if($ratio_w < $ratio_h) 
		{
			$ratio = $ratio_h ; // ���һ����ȵı����ȸ߶ȷ����С�����ո߶ȵı�����׼���ü���Ŵ�
		}
		else 
		{
			$ratio = $ratio_w ;
		}
		// ����һ���м����ʱͼ�񣬸�ͼ��Ŀ�߱� ��������Ŀ��Ҫ��
		$inter_w=(int)($new_width / $ratio);
		$inter_h=(int) ($new_height / $ratio);
		$inter_img=imagecreatetruecolor($inter_w , $inter_h);
		imagecopy($inter_img, $src_img, 0,0,0,0,$inter_w,$inter_h);
		// ����һ�������߳���Ϊ��С����Ŀ��ͼ��$ratio��������ʱͼ��
		// ����һ���µ�ͼ��
		$new_img=imagecreatetruecolor($new_width,$new_height);
		imagecopyresampled($new_img,$inter_img,0,0,0,0,$new_width,$new_height,$inter_w,$inter_h);
		switch($type) 
		{
			case IMAGETYPE_JPEG :
				imagejpeg($new_img, $dst_file,85); // �洢ͼ��
				break;
			case IMAGETYPE_PNG :
				imagepng($new_img,$dst_file,85);
				break;
			case IMAGETYPE_GIF :
				imagegif($new_img,$dst_file,85);
				break;
			default:
				break;
		}
	}
	// 2 Ŀ��ͼ�� ��һ���ߴ���ԭͼ��һ����С��ԭͼ ���ȷŴ�ƽ��ͼ��Ȼ��ü�
	// =if( ($ratio_w < 1 && $ratio_h > 1) || ($ratio_w >1 && $ratio_h <1) )
	else
	{
		$ratio=$ratio_h>$ratio_w? $ratio_h : $ratio_w; //ȡ��������Ǹ�ֵ
		// ����һ���м�Ĵ�ͼ�񣬸�ͼ��ĸ߻���Ŀ��ͼ����ȣ�Ȼ���ԭͼ�Ŵ�
		$inter_w=(int)($w * $ratio);
		$inter_h=(int) ($h * $ratio);
		$inter_img=imagecreatetruecolor($inter_w , $inter_h);
		//��ԭͼ���ű�����ü�
		imagecopyresampled($inter_img,$src_img,0,0,0,0,$inter_w,$inter_h,$w,$h);
		// ����һ���µ�ͼ��
		$new_img=imagecreatetruecolor($new_width,$new_height);
		imagecopy($new_img, $inter_img, 0,0,0,0,$new_width,$new_height);
		switch($type) 
		{
		case IMAGETYPE_JPEG :
			imagejpeg($new_img, $dst_file,85); // �洢ͼ��
			break;
		case IMAGETYPE_PNG :
			imagepng($new_img,$dst_file,85);
			break;
		case IMAGETYPE_GIF :
			imagegif($new_img,$dst_file,85);
			break;
		default:
			break;
		}
	}
}
?>